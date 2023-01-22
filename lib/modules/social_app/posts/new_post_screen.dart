import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  DateTime nowTime = DateTime.now();

  NewPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            TextButton(
              onPressed: () {
                if (SocialCubit.get(context).postImage == null) {
                  SocialCubit.get(context).createPost(
                    text: textController.text,
                    dateTime: nowTime.toString(),
                  );
                } else {
                  SocialCubit.get(context).uploadPostImage(
                    text: textController.text,
                    dateTime: nowTime.toString(),
                  );
                }
              },
              child: const Text('POST'),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(height: 10),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1641754179550-811621f2b70d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NTJ8NTE2OTY2fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Yasir Osman',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'What is on your minde ...',
                        border: InputBorder.none),
                    maxLines: 20,
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                           SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            Text('Add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
