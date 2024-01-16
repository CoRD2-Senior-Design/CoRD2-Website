class ChatModel {
  final Map<String, String> participant;
  final List<String> participants;
  final DateTime lastUpdate;
  final String? id;

  ChatModel(this.participant, this.participants, this.lastUpdate, this.id);

}