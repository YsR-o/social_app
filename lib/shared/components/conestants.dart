import '../../modules/social_app/login/social_login_screen.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';


void logOut(context) {
  CashHelper.removeData(key: 'uId').then(
    (value) {
      if (value) navigateAndKill(context, SocialLoginScreen());
    },
  );
}

String? token = '';

String? uId = '';
