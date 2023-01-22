import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'layout/social_app/cubit_theme_mode/mode_cubit.dart';
import 'layout/social_app/cubit_theme_mode/mode_states.dart';
import 'layout/social_app/home_layout.dart';
import 'modules/social_app/login/social_login_screen.dart';
import 'shared/components/conestants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'shared/network/local/cash_helper.dart';
import 'shared/network/remote/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = SimpleBlocObserver();
  await CashHelper.init();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
var token = await FirebaseMessaging.instance.getToken();
FirebaseMessaging.onMessage.listen((event) {
});
  Widget widget;
  bool? isDark = CashHelper.getData(key: 'isDark');
 // bool? onBording = CashHelper.getData(key: 'onBording');
//  token = CashHelper.getData(key: 'token');

  uId = CashHelper.getData(key: 'uId');

  // if (onBording != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBordingScreen();
  // }
if (uId != null){
  widget = const SocialLayout();
}else{
  widget= SocialLoginScreen();
}

  runApp(MyApp(isDark ?? false, widget));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, this.startWidget, {super.key});
  final bool isDark;
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts()
        ),
      ],
      child: BlocConsumer<AppModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home:startWidget,
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
