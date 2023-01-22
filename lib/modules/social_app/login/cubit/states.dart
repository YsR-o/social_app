abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginErorState extends SocialLoginStates {

  final String error;

  SocialLoginErorState(this.error);
}

class ChangeVisibilityState extends SocialLoginStates {}

