import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';
import '../../../models/social_app/message_model.dart';
import '../../../models/social_app/post_model.dart';
import '../../../models/social_app/user_model.dart';
import '../../../modules/social_app/chat/chat_screen.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';
import '../../../modules/social_app/posts/new_post_screen.dart';
import '../../../modules/social_app/settings/settings_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';
import '../../../shared/components/conestants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUsersLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId ?? userModel?.uId)
        .get()
        .then((value) {
      value.data();
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetUsersErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<String> titles = ['home', 'Chats', 'Add Post', 'Users', 'Setting'];
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
    if (index == 1) {
      getAllUsers();
    }
    // if (index == 4 && userModel == null) {
    //   getUserData();
    // }
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getImageProfile() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getImagecover() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
    String? image,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        SocialUploadProfileImageErrorState();
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
    String? cover,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        SocialUploadCoverImageErrorState();
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    final model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      email: userModel?.email,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
      uId: userModel?.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toFirestore())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

/* posts */
  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        SocialCreatePostErrorState();
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    final model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toFirestore())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(
        SocialGetPostsErrorState(),
      );
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({
      'likes': true,
    }).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var user in value.docs) {
          if (user.id != uId) {
            users.add(SocialUserModel.fromJson(user.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String? receiverId,
    required String dateTime,
    required String text,
  }) {
    final model = MessageModel(
      senderId: userModel?.uId,
      dateTime: dateTime,
      receiverId: receiverId,
      text: text,
    );

    // set my chat 'sender'

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toFirestore())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    // set reveiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('message')
        .add(model.toFirestore())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];
  void getMessages({required String? receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
         messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
    });
    emit(SocialGetMessageSuccessState());
  }
}
