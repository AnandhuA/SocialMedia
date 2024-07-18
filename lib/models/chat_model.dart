class Conversation {
  String id;
  List<String> members;
  DateTime createdAt;
  DateTime updatedAt;
  int version;
  String lastMessage;
  DateTime lastMessageTime;

  Conversation({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      members: List<String>.from(json['members']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
      lastMessage: json['lastMessage'],
      lastMessageTime: DateTime.parse(json['lastMessageTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'members': members,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
    };
  }
}

class ConversationResponse {
  int status;
  String message;
  List<Conversation> data;

  ConversationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      status: json['status'],
      message: json['message'],
      data: List<Conversation>.from(
        json['data']
            .map((conversationJson) => Conversation.fromJson(conversationJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((conversation) => conversation.toJson()).toList(),
    };
  }
}


class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String conversationId;
  final String text;
  final bool isRead;
  final String deleteType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.text,
    required this.isRead,
    required this.deleteType,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['recieverId'],
      conversationId: json['conversationId'],
      text: json['text'],
      isRead: json['isRead'],
      deleteType: json['deleteType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId,
      'recieverId': receiverId,
      'conversationId': conversationId,
      'text': text,
      'isRead': isRead,
      'deleteType': deleteType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class MessageResponse {
  final List<Message> data;
  final int status;
  final String message;

  MessageResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Message> messages = dataList.map((i) => Message.fromJson(i)).toList();

    return MessageResponse(
      data: messages,
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((message) => message.toJson()).toList(),
      'status': status,
      'message': message,
    };
  }
}
