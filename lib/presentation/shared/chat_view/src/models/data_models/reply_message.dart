import '../../values/enumeration.dart';

class ReplyMessage {
  /// Provides reply message.
  final String message;

  /// Provides user id of who replied message.
  final String replyBy;

  /// Provides user id of whom to reply.
  final String replyTo;
  final MessageType messageType;

  /// Provides max duration for recorded voice message.
  final Duration? voiceMessageDuration;

  /// Id of message, it replies to.
  final String messageId;

  const ReplyMessage({
    this.messageId = '',
    this.message = '',
    this.replyTo = '',
    this.replyBy = '',
    this.messageType = MessageType.text,
    this.voiceMessageDuration,
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json['message']?.toString() ?? '',
        replyBy: json['replyBy']?.toString() ?? '',
        replyTo: json['replyTo']?.toString() ?? '',
        messageType: MessageType.tryParse(json['message_type']?.toString()) ?? MessageType.text,
        messageId: json['id']?.toString() ?? '',
        voiceMessageDuration: Duration(
          microseconds: int.tryParse(json['voiceMessageDuration'].toString()) ?? 0,
        ),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'replyBy': replyBy,
        'replyTo': replyTo,
        'message_type': messageType.name,
        'id': messageId,
        'voiceMessageDuration': voiceMessageDuration?.inMicroseconds,
      };

  ReplyMessage copyWith({
    String? messageId,
    String? message,
    String? replyTo,
    String? replyBy,
    MessageType? messageType,
    Duration? voiceMessageDuration,
    bool forceNullValue = false,
  }) {
    return ReplyMessage(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      replyTo: replyTo ?? this.replyTo,
      replyBy: replyBy ?? this.replyBy,
      messageType: messageType ?? this.messageType,
      voiceMessageDuration: forceNullValue ? voiceMessageDuration : voiceMessageDuration ?? this.voiceMessageDuration,
    );
  }
}
