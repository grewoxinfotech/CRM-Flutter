import 'dart:async';
import 'dart:convert';
import 'package:crm_flutter/app/data/network/communication/chat/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketEvent {
  final String type;
  final dynamic data;
  SocketEvent(this.type, this.data);
}

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;
  final _eventController = StreamController<SocketEvent>.broadcast();

  Stream<SocketEvent> get events => _eventController.stream;
  bool get isConnected => _socket?.connected ?? false;

  /// Connect to Socket.IO server
  void connect(
    String url, {
    required String userId,
    Map<String, dynamic>? query,
  }) {
    if (_socket != null && _socket!.connected) return;

    try {
      _socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setQuery(query ?? {})
            .disableAutoConnect()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .setTimeout(10000)
            .build(),
      );

      _socket!.connect();

      _socket!.onConnect((_) {
        _socket!.emit('user_connected', userId);
        _socket!.emit('get_conversations', {'userId': userId});
        _safeAdd(SocketEvent('connect', null));
        print('✅ Connected with ID: ${_socket?.id}');
      });

      _socket!.onDisconnect((_) {
        print('❌ Disconnected');
        _safeAdd(SocketEvent('disconnect', null));
        Future.delayed(const Duration(seconds: 3), () {
          if (!isConnected) _socket?.connect();
        });
      });

      _socket!.onConnectError((err) {
        print('⚠️ Connect error: $err');
        _safeAdd(SocketEvent('error', err.toString()));
      });

      _socket!.onError((err) {
        print('⚠️ Socket error: $err');
        _safeAdd(SocketEvent('error', err.toString()));
      });

      // Catch-all for debugging
      _socket!.onAny((event, data) {
        print('📡 Event: $event → ${jsonEncode(data)}');
        _safeAdd(SocketEvent(event, data));
      });
    } catch (e) {
      print('❌ Socket initialization error: $e');
      _safeAdd(SocketEvent('error', e.toString()));
    }
  }

  /// Disconnect socket but keep stream open
  void disconnect() {
    try {
      _socket?.disconnect();
      _socket?.destroy();
      _socket = null;
      _safeAdd(SocketEvent('disconnect', null));
    } catch (e) {
      print('❌ Error disconnecting: $e');
    }
  }

  /// Send a chat message
  void sendMessage(ChatMessage message) {
    if (isConnected) {
      final data = message.toJson();
      print('📤 Sending message: ${jsonEncode(data)}');
      _socket?.emit('send_message', data);
    } else {
      print('❌ Cannot send message: not connected');
    }
  }

  /// Send file in chat
  void sendFileChat(UploadChatFilesRequest data) {
    if (isConnected) {
      _socket?.emit('upload_chat_files', data);
      print('📤 Sent file chat: ${data.toJson()}');
    }
  }

  void markMessagesRead(ReadReceipt receipt) {
    if (isConnected) {
      _socket?.emit('mark_messages_read', receipt.toJson());
      print('📤 Marked messages read in conversation: ${receipt.toJson()}');
    }
  }

  /// Get conversations for a user
  void getConversations(String userId) {
    if (isConnected) _socket?.emit('get_conversations', {'userId': userId});
  }

  /// Send typing status
  void sendTyping(TypingEvent typing) {
    if (isConnected) {
      _socket?.emit('typing', typing.toJson());
      print('📤 Sent typing: ${typing.toJson()}');
    }
  }

  /// Dispose socket (safe singleton)
  void dispose() {
    disconnect();
  }

  /// Destroy everything (use on logout)
  void destroy() {
    disconnect();
    if (!_eventController.isClosed) _eventController.close();
  }

  void _safeAdd(SocketEvent event) {
    if (!_eventController.isClosed) _eventController.add(event);
  }
}
