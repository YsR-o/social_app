class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel(
      {this.name,
      this.uId,
      this.image,
      this.dateTime,
      this.text,
      this.postImage});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) 'name': name,
      if (uId != null) 'email': uId,
      if (image != null) 'image': image,
      if (dateTime != null) 'dateTime': dateTime,
      if (text != null) 'text': text,
      if (postImage != null) 'postImage': postImage,
    };
  }
}
