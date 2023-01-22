abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterErorState extends SocialRegisterStates {

  final String error;

  SocialRegisterErorState(this.error);
}

class ChangeVisibilityState extends SocialRegisterStates {}

class SocialUserCreateLoadingtate extends SocialRegisterStates {}

class SocialUserCreateSuccessState extends SocialRegisterStates {}

class SocialUserCreateErrorState extends SocialRegisterStates {

  final String error;

  SocialUserCreateErrorState(this.error);
}
