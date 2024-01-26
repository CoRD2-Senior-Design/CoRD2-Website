class MessageModel {
  final String contents;
  final DateTime time;
  final String senderId;
  final bool didSend;

  MessageModel(this.contents, this.time, this.senderId, this.didSend);
}