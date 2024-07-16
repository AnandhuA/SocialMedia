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
