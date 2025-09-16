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

  void connect(String url, {Map<String, dynamic>? query, String? roomId}) {
    if (_socket != null && _socket!.connected) return;

    try {
      _socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling']) // Enable both transport methods
            .setQuery(query ?? {})
            .enableReconnection()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .setTimeout(10000)
            .enableForceNew() // Force new connection
            .setExtraHeaders({'Connection': 'upgrade', 'Upgrade': 'websocket'})
            .build(),
      );

      _socket!.connect();

      _socket!.onConnect((_) {
        print('✅ Connected to socket with ID: ${_socket?.id}');
        _safeAdd(SocketEvent('connect', null));

        // Auto join room if provided
        if (roomId != null) {
          joinRoom(roomId);
        } else if (_socket!.id != null) {
          joinRoom(_socket!.id!);
        }
      });

      _socket!.onConnectError((error) {
        print('⚠️ Socket connection error: $error');
        _safeAdd(SocketEvent('error', error.toString()));
      });

      _socket!.onDisconnect((_) {
        print('❌ Disconnected from socket');
        _safeAdd(SocketEvent('disconnect', null));

        // Try to reconnect after disconnect
        Future.delayed(const Duration(seconds: 3), () {
          if (!(_socket?.connected ?? false)) {
            print('🔄 Attempting to reconnect...');
            _socket?.connect();
          }
        });
      });

      _socket!.onError((error) {
        print('⚠️ Socket error: $error');
        _safeAdd(SocketEvent('error', error.toString()));
      });

      // Debug: catch ALL events
      _socket!.onAny((event, data) {
        print('📡 Event: $event → ${jsonEncode(data)}');
        _safeAdd(SocketEvent(event, data));
      });

      // Explicit listener for messages with better error handling
      _socket!.on('receive_message', (data) {
        try {
          print('📩 Raw message received: ${jsonEncode(data)}');
          _safeAdd(SocketEvent('receive_message', data));
        } catch (e) {
          print('❌ Error processing received message: $e');
          print('Message data was: $data');
        }
      });

      // Listen for specific connection events
      _socket!.on('connect_error', (data) => print('🔴 Connect Error: $data'));
      _socket!.on('connect_timeout', (data) => print('🔴 Connect Timeout: $data'));
      _socket!.on('reconnect', (data) => print('🔄 Reconnected: attempt $data'));
      _socket!.on('reconnect_attempt', (data) => print('🔄 Reconnection Attempt: $data'));
      _socket!.on('reconnect_error', (data) => print('🔴 Reconnect Error: $data'));
      _socket!.on('reconnect_failed', (data) => print('🔴 Reconnect Failed: $data'));
      _socket!.on('ping', (_) => print('📍 Ping'));
      _socket!.on('pong', (data) => print('📍 Pong: $data ms'));

    } catch (e) {
      print('❌ Error initializing socket: $e');
      _safeAdd(SocketEvent('error', e.toString()));
    }
  }

  void disconnect() {
    try {
      _socket?.dispose();  // Properly dispose all listeners
      _socket?.disconnect();
      _socket?.close();
      _socket?.destroy(); // Completely destroy the socket instance
      _socket = null;
      _safeAdd(SocketEvent('disconnect', null));
    } catch (e) {
      print('❌ Error during disconnect: $e');
    }
  }

  void joinRoom(String roomId) {
    if (_socket?.connected ?? false) {
      print('🔄 Joining room: $roomId');
      _socket?.emit('join', {'roomId': roomId});
    } else {
      print('❌ Cannot join room: Socket not connected');
    }
  }

  void sendMessage(ChatMessage message) {
    if (_socket?.connected ?? false) {
      final data = message.toJson();
      print('📤 Sending message: ${jsonEncode(data)}');
      _socket?.emit('send_message', data);
    } else {
      print('❌ Cannot send message: Socket not connected');
    }
  }

  void sendFileChat(ChatFile data) {
    _socket?.emit('upload_chat_files', data);
    print("📤 Sent file chat: ${data.toJson()}");
  }

  void getConversations(String userId) {
    _socket?.emit('get_conversations', {'userId': userId});
  }

  void sendTyping(TypingEvent typing) {
    _socket?.emit('typing', typing);
    print("📤 Sent typing: ${typing.toJson()}");
  }

  /// Only disconnect socket, keep stream open (safe for singleton use)
  void dispose() {
    disconnect();
    // ⚠️ Do NOT close _eventController, otherwise future socket events will crash
  }

  /// If you are *sure* you will never use this service again (e.g., on logout),
  /// call this to free everything.
  void destroy() {
    disconnect();
    if (!_eventController.isClosed) {
      _eventController.close();
    }
  }

  void _safeAdd(SocketEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }
}
