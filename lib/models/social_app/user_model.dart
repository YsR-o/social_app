class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;

  bool? isEmailVerified;

  SocialUserModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.image,
      this.cover,
      this.bio});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) 'name': name,
      if (uId != null) 'uId': uId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (image != null) 'image': image,
      if (cover != null) 'cover': cover,
      if (bio != null) 'bio': bio,
      if (isEmailVerified != null) 'isEmailVerified': isEmailVerified,
    };
  }
}
