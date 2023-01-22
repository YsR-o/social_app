import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/register/cubit/states.dart';

import '../../../../models/social_app/user_model.dart';
import '../../../../shared/network/local/cash_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeVisibility() {
    isPassword = !isPassword;
    isPassword
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(ChangeVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        userCreate(
          name: name,
          email: email,
          uId: value.user!.uid,
          image:
              'https://images.unsplash.com/photo-1641754179550-811621f2b70d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NTJ8NTE2OTY2fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
          cover:
              'https://st.depositphotos.com/16173130/51390/i/450/depositphotos_513906114-stock-photo-september-2021-tumkur-district-karnataka.jpg',
          bio: 'Write your Bio....',
          phone: phone,
        );
        CashHelper.saveData(key: 'uId', value: value.user!.uid);

        emit(SocialRegisterSuccessState());
      },
    ).catchError(
      (erorr) {
        emit(SocialRegisterErorState(erorr.toString()));
      },
    );
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String image,
    required String cover,
    required String bio,
    required String phone,
  }) {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        image: image,
        cover: cover,
        bio: bio,
        uId: uId,
        isEmailVerified: false);

    emit(SocialUserCreateLoadingtate());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toFirestore())
        .then((value) {
      emit(SocialUserCreateSuccessState());
    }).catchError((error) {
      emit(SocialUserCreateErrorState(error.toString()));
    });
  }
}
