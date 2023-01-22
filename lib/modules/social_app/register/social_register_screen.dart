import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:social_app/modules/social_app/register/cubit/cubit.dart';
import 'package:social_app/modules/social_app/register/cubit/states.dart';

import '../../../layout/social_app/home_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
            if(state is SocialRegisterErorState){
              EasyLoading.showToast(state.error.toString(),
                  toastPosition: EasyLoadingToastPosition.bottom,
                  maskType: EasyLoadingMaskType.clear);
            }
            if (state is SocialUserCreateSuccessState){
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
                          Text('REGISTER',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.black)),
                          Text('Register now to communicate with freinds',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 30,
                          ),defaultTextFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              label: 'Name',
                              prefix: Icons.person_outline,
                              validate: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'please enter your Nmae';
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
                                  SocialRegisterCubit.get(context).isPassword,
                              prefix: Icons.lock_outline,
                              suffix: SocialRegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changeVisibility();
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
                          defaultTextFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              label: 'phone',
                              prefix: Icons.phone_android_rounded,
                              validate: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'please enter your Phone';
                                }
                              },
                              onTap: () {},
                              onChange: (value) {
                                return null;
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          state is SocialRegisterLoadingState
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
                                        SocialRegisterCubit.get(context)
                                            .userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'REGISTER NOW',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
