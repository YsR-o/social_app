class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessageModel(
      {this.senderId,
      this.receiverId,
      this.dateTime,
      this.text,
      });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (senderId != null) 'senderId': senderId,
      if (receiverId != null) 'receiverId': receiverId,
      if (dateTime != null) 'dateTime': dateTime,
      if (text != null) 'text': text,
    };
  }
}
