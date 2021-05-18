enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final String sendTime;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text,
    this.sendTime,
    this.messageType,
    this.messageStatus,
    this.isSender,
  });
}

List demoChatMessages = [
  ChatMessage(
    text: "Hey",
    sendTime: "11:45 AM",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "What’s up bro?",
    sendTime: "11:45 AM",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "Can we goto the park tonight?",
    sendTime: "11:45 AM",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Sure, meet you at the station at 06:30 PM",
    sendTime: "11:45 AM",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
  ChatMessage(
    text: "OK, See you then",
    sendTime: "11:45 AM",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
];
