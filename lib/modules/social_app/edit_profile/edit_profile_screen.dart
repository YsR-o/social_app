import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();

  EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        nameController.text = model!.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;

        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        final cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: const Text('UPDATE'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(model.cover!)
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    cubit.getImagecover();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(model.image!)
                                  : FileImage(profileImage) as ImageProvider),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                cubit.getImageProfile();
                              },
                              icon: const Icon(
                                IconBroken.Camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  width: double.infinity,
                                  text: 'upload profile',
                                  onPressed: () {
                                    cubit.uploadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                ),
                                if (state is SocialUpdateUserLoadingState)
                                  const SizedBox(height: 5),
                                if (state is SocialUpdateUserLoadingState)
                                  const LinearProgressIndicator()
                              ],
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  width: double.infinity,
                                  text: 'upload cover',
                                  onPressed: () {
                                    cubit.uploadCoverImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                ),
                                if (state is SocialUpdateUserLoadingState)
                                  const SizedBox(height: 5),
                                if (state is SocialUpdateUserLoadingState)
                                  const LinearProgressIndicator()
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (profileImage != null || coverImage != null)
                    const SizedBox(height: 20),
                  defaultTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.User,
                      onTap: () {},
                      onChange: (vlau) {
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: bioController,
                      type: TextInputType.name,
                      label: 'Bio',
                      prefix: IconBroken.Location,
                      onTap: () {},
                      onChange: (vlau) {
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone Number',
                      prefix: IconBroken.Call,
                      onTap: () {},
                      onChange: (vlau) {
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
