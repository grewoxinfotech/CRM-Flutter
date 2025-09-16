// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:async';
//
// import 'chat_model.dart'; // your enums & models file
//
// class ChatService {
//   static final ChatService _instance = ChatService._internal();
//   factory ChatService() => _instance;
//   ChatService._internal();
//
//   late IO.Socket _socket;
//   bool _isConnected = false;
//
//   // Stream controllers for different event types
//   final _eventController = StreamController<ChatEvent>.broadcast();
//   Stream<ChatEvent> get events => _eventController.stream;
//
//   /// Connect to socket server
//   void connect(String url, {Map<String, dynamic>? query}) {
//     if (_isConnected) return;
//
//     _socket = IO.io(
//       url,
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableReconnection()
//           .setQuery(query ?? {})
//           .build(),
//     );
//
//     _socket.onConnect((_) {
//       _isConnected = true;
//       print("✅ Connected to chat server");
//     });
//
//     _socket.onDisconnect((_) {
//       _isConnected = false;
//       print("❌ Disconnected from chat server");
//     });
//
//     _socket.onReconnect((_) {
//       print("♻️ Reconnected to chat server");
//     });
//
//     _socket.onError((err) {
//       print("⚠️ Socket error: $err");
//     });
//
//     // Generic event listener
//     _socket.on('event', (data) {
//       print("🔹 Raw event received: $data");
//
//       try {
//         if (data is List) {
//           final event = ChatEvent.fromJson(data);
//           _eventController.add(event);
//           print("✅ Event parsed: ${event.type} with data: ${event.data}");
//         } else {
//           print("⚠️ Unexpected event format: ${data.runtimeType}");
//         }
//       } catch (e) {
//         print("⚠️ Failed to parse event: $e");
//       }
//     });
//   }
//
//   /// Disconnect safely
//   void disconnect() {
//     if (_isConnected) {
//       _socket.disconnect();
//       _isConnected = false;
//       print("❌ Socket disconnected manually");
//     }
//   }
//
//   /// Send message
//   void sendMessage(ChatMessage message) {
//     if (!_isConnected) return;
//     _socket.emit('event', [ChatEventType.sendMessage.value, message.toJson()]);
//     print("📤 Sent message: ${message.toJson()}");
//   }
//
//   /// Mark messages as read
//   void markMessagesRead(ReadReceipt receipt) {
//     if (!_isConnected) return;
//     _socket.emit('event', [
//       ChatEventType.markMessagesRead.value,
//       receipt.toJson(),
//     ]);
//     print("📤 Marked messages read: ${receipt.toJson()}");
//   }
//
//   /// Send typing event
//   void sendTyping(TypingEvent typing) {
//     if (!_isConnected) return;
//     _socket.emit('event', [ChatEventType.typing.value, typing.toJson()]);
//     print("📤 Sent typing: ${typing.toJson()}");
//   }
//
//   // /// Upload chat files
//   // void uploadFiles(ChatUpload upload) {
//   //   if (!_isConnected) return;
//   //   _socket.emit('event', [ChatEventType.uploadChatFiles.value, upload.toJson()]);
//   //   print("📤 Uploading files: ${upload.toJson()}");
//   // }
// }

// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:async';
// import 'chat_model.dart'; // your enums & models file
//
// class ChatService {
//   static final ChatService _instance = ChatService._internal();
//   factory ChatService() => _instance;
//   ChatService._internal();
//
//   late IO.Socket _socket;
//   bool _isConnected = false;
//
//   // Stream controller for all incoming events
//   final _eventController = StreamController<ChatEvent>.broadcast();
//   Stream<ChatEvent> get events => _eventController.stream;
//
//   /// Connect to socket server
//   void connect(String url, {Map<String, dynamic>? query}) {
//     if (_isConnected) return;
//
//     _socket = IO.io(
//       url,
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableReconnection()
//           .setQuery(query ?? {})
//           .build(),
//     );
//
//     _socket.onConnect((_) {
//       _isConnected = true;
//       print("✅ Connected to chat server");
//     });
//
//     _socket.onDisconnect((_) {
//       _isConnected = false;
//       print("❌ Disconnected from chat server");
//     });
//
//     _socket.onReconnect((_) {
//       print("♻️ Reconnected to chat server");
//     });
//
//     _socket.onError((err) {
//       print("⚠️ Socket error: $err");
//     });
//
//     // Generic event listener for server events
//     _socket.on('event', (data) {
//       try {
//         final event = ChatEvent(type: data[0], data: data);
//         _eventController.add(event);
//         print("✅ Event parsed: ${data[0]} with data: $data");
//       } catch (e) {
//         print("⚠️ Failed to parse event: $e");
//       }
//     });
//   }
//
//   /// Disconnect safely
//   void disconnect() {
//     if (_isConnected) {
//       _socket.disconnect();
//       _isConnected = false;
//       print("❌ Socket disconnected manually");
//     }
//   }
//
//   /// Send a chat message
//   void sendMessage(ChatMessage message) {
//     if (!_isConnected) return;
//     _socket.emit('send_message', [
//       ChatEventType.sendMessage.value,
//       message.toJson(),
//     ]);
//     print("📤 Sent message: ${message.toJson()}");
//   }
//
//   /// Send typing event
//   void sendTyping(TypingEvent typing) {
//     if (!_isConnected) return;
//     _socket.emit('event', [ChatEventType.typing.value, typing.toJson()]);
//     print("📤 Sent typing: ${typing.toJson()}");
//   }
//
//   // /// Upload chat files
//   // void uploadFiles(ChatUpload upload) {
//   //   if (!_isConnected) return;
//   //   _socket.emit(
//   //     'event',
//   //     [ChatEventType.uploadChatFiles.value, upload.toJson()],
//   //   );
//   //   print("📤 Uploading files: ${upload.toJson()}");
//   // }
// }

// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:async';
// import 'chat_model.dart'; // your enums & models file
//
// class ChatService {
//   static final ChatService _instance = ChatService._internal();
//   factory ChatService() => _instance;
//   ChatService._internal();
//
//   late IO.Socket _socket;
//   bool _isConnected = false;
//
//   /// Stream controller for all incoming events
//   final _eventController = StreamController<ChatEvent>.broadcast();
//   Stream<ChatEvent> get events => _eventController.stream;
//
//   /// Connect to socket server
//   void connect(String url, {Map<String, dynamic>? query}) {
//     if (_isConnected) return;
//
//     _socket = IO.io(
//       url,
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableReconnection()
//           .setQuery(query ?? {})
//           .build(),
//     );
//
//     _socket.onConnect((_) {
//       _isConnected = true;
//       print("✅ Connected to chat server");
//     });
//
//     _socket.onDisconnect((_) {
//       _isConnected = false;
//       print("❌ Disconnected from chat server");
//     });
//
//     _socket.onReconnect((_) {
//       print("♻️ Reconnected to chat server");
//     });
//
//     _socket.onError((err) {
//       print("⚠️ Socket error: $err");
//     });
//
//     /// Listen for all generic events
//     _socket.on('event', (data) {
//       try {
//         if (data is List<dynamic>) {
//           print("🔹 Raw event received: $data");
//           final event = ChatEvent.fromJson(data);
//           _eventController.add(event);
//           print("✅ Event parsed: ${event.type.value} with data: ${event.data}");
//         } else {
//           print("⚠️ Received invalid event data: $data");
//         }
//       } catch (e) {
//         print("⚠️ Failed to parse event: $e");
//       }
//     });
//   }
//
//   /// Disconnect safely
//   void disconnect() {
//     if (_isConnected) {
//       _socket.disconnect();
//       _isConnected = false;
//       print("❌ Socket disconnected manually");
//     }
//   }
//
//   /// Send a chat message
//   void sendMessage(ChatMessage message) {
//     if (!_isConnected) return;
//     _socket.emit('send_message', [
//       ChatEventType.sendMessage.value,
//       message.toJson(),
//     ]);
//     print("📤 Sent message: ${message.toJson()}");
//   }
//
//   void getMessage(String userId) {
//     if (!_isConnected) return;
//     print("Getting messages for user: $userId");
//     _socket.emit('get_conversations', {"userId": "IPoucZkvAMQ0BX1owqj5jxK"});
//
//     print("📤 Requested conversations for user: $userId");
//   }
//
//   /// Send typing event
//   void sendTyping(TypingEvent typing) {
//     if (!_isConnected) return;
//     _socket.emit('event', [ChatEventType.typing.value, typing.toJson()]);
//     print("📤 Sent typing: ${typing.toJson()}");
//   }
//
//   /// Upload chat files
//   void uploadFiles(UploadChatFiles upload) {
//     if (!_isConnected) return;
//     _socket.emit('event', [
//       ChatEventType.uploadChatFiles.value,
//       upload.toJson(),
//     ]);
//     print("📤 Uploading files: ${upload.toJson()}");
//   }
// }
//

import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'chat_model.dart';

class SocketService {
  // Singleton pattern
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;

  // Event streams
  final _eventController = StreamController<SocketEvent>.broadcast();
  Stream<SocketEvent> get events => _eventController.stream;

  bool get isConnected => _socket?.connected ?? false;

  /// Connect to socket
  void connect(String url, {Map<String, dynamic>? query}) {
    if (_socket != null && _socket!.connected) return;

    try {
      _socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .enableReconnection()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .setTimeout(10000)
            .setQuery(query ?? {})
            .build(),
      );

      _socket!.onConnect((_) {
        print('✅ Connected to socket server');
      });

      _socket!.onConnectError((error) {
        print('⚠️ Socket connection error: $error');
      });

      _socket!.onDisconnect((_) {
        print('❌ Disconnected from socket server');
      });

      _socket!.onError((error) {
        print('⚠️ Socket error: $error');
      });

      // Forward any custom events to the event controller
      _socket!.onAny((event, data) {
        _eventController.add(SocketEvent(event, data));
      });
    } catch (e) {
      print('Error connecting to socket: $e');
    }
  }

  /// Disconnect from socket
  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  /// Join a private room
  void joinRoom(String userId) {
    _socket?.emit('join_room', userId);
  }

  /// Send private message
  void sendMessage(ChatMessage message) {
    if (_socket == null) return;

    final data = message.toJson();
    data['message'] = message.message.trim();
    data['timestamp'] = DateTime.now().toIso8601String();

    _socket!.emit('send_message', data);
  }

  /// Get conversations
  void getConversations(String userId) {
    _socket?.emit('get_conversations', {'userId': userId});
    print("📤 Requested conversations for user: $userId");
  }

  /// Update message status
  void updateMessageStatus(Map<String, dynamic> data) {
    _socket?.emit('update_message_status', data);
  }

  /// Delete message
  void deleteMessage(Map<String, dynamic> data) {
    _socket?.emit('delete_message', data);
  }

  /// Typing indicator
  void sendTyping(TypingEvent typing) {
    _socket?.emit('typing', typing.toJson());
  }

  /// Group chat features
  void createGroup(Map<String, dynamic> groupData) {
    _socket?.emit('create_group', groupData);
  }

  void joinGroup(String groupId, String userId) {
    _socket?.emit('join_group', {'groupId': groupId, 'userId': userId});
  }

  void leaveGroup(String groupId, String userId) {
    _socket?.emit('leave_group', {'groupId': groupId, 'userId': userId});
  }

  void sendGroupMessage(String groupId, Map<String, dynamic> message) {
    _socket?.emit('group_message', {'groupId': groupId, ...message});
  }

  void markMessagesAsRead(Map<String, dynamic> data) {
    _socket?.emit('mark_messages_read', data);
  }

  /// Upload files
  Future<dynamic> sendFiles(Map<String, dynamic> data) async {
    if (_socket == null) throw Exception('Socket not connected');

    final completer = Completer<dynamic>();
    _socket!.emitWithAck(
      'upload_chat_files',
      data,
      ack: (response) {
        if (response['error'] != null) {
          completer.completeError(response['error']);
        } else {
          completer.complete(response);
        }
      },
    );
    return completer.future;
  }

  /// Dispose
  void dispose() {
    _eventController.close();
    disconnect();
  }
}

/// Generic socket event wrapper
class SocketEvent {
  final String type;
  final dynamic data;

  SocketEvent(this.type, this.data);
}
