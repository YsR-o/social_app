import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/login/cubit/cubit.dart';
import 'package:social_app/modules/social_app/login/cubit/states.dart';

import '../../../layout/social_app/home_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../../../shared/styles/colors.dart';
import '../register/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            CashHelper.saveData(
              key: 'uId',
              value: state.uId,
            );
            navigateAndKill(context, const SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black)),
                        Text('login now to communicate with freinds',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value != null && value.isEmpty) {
                                return 'please enter your Email';
                              }
                              return null;
                            },
                            onTap: () {},
                            onChange: (value) {
                              return null;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'PassWord',
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            prefix: Icons.lock_outline,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialLoginCubit.get(context).changeVisibility();
                            },
                            validate: (value) {
                              if (value != null && value.length < 4) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            onTap: () {},
                            onChange: (value) {
                              return null;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        state is SocialLoginLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: defaultColor,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    final isVaildForm =
                                        formkey.currentState!.validate();
                                    if (isVaildForm) {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    SocialRegisterScreen(),
                                  );
                                },
                                child: const Text('REGISTER'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
