import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/conestants.dart';
import '../../../shared/styles/icon_broken.dart';
import '../edit_profile/edit_profile_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return model == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                    image: NetworkImage(model.cover!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(model.image!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      model.name!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.bio!,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '317',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '67K',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '24',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Add Photos'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            navigateTo(context, EditProfileScreen());
                          },
                          child: const Icon(
                            IconBroken.Edit,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton(
                          onPressed: () {
                            logOut(context);
                          },
                          child: const Icon(
                            IconBroken.Logout,
                            size: 20,
                          ),
                        ),
                  ],
                ),
              );
      },
    );
  }
}
