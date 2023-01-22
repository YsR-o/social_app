import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/post_model.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';
class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (contxet, state) {},
        builder: (context, state) {
          return SocialCubit.get(context).posts.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Card(
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1641754179550-811621f2b70d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NTJ8NTE2OTY2fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                            fit: BoxFit.cover,
                            height: 170,
                            width: double.infinity,
                          ),
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildFeeds(
                              context, SocialCubit.get(context).posts[index],index),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          itemCount: SocialCubit.get(context).posts.length,
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        });
  }

  Widget buildFeeds(context, PostModel model,int index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${model.image}'),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 15,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    IconBroken.More_Circle,
                    color: Colors.grey,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[350],
                height: 1,
                width: double.infinity,
              ),
              Text(
                '${model.text}',
              ),
              Wrap(
                spacing: 4.0,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '#Just_Test',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '#Just_Test',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '#Just_Test',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '#Just_Test',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '#Just_Test',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                  ),
                ],
              ),
              if (model.postImage != '')
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${model.postImage}'),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${SocialCubit.get(context).likes[index]} Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Icon(IconBroken.Chat,
                          color: Colors.amber, size: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '0 comment',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Write a comment',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Like',
                    style: Theme.of(context).textTheme.caption,
                  ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      IconBroken.Upload,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Share',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
