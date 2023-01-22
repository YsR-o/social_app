import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/user_model.dart';
import '../../../shared/components/components.dart';
import '../chat_details/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return 
           SocialCubit.get(context).users.isEmpty?
           const Center(child: CircularProgressIndicator()):
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildChatItem(model: 
                          SocialCubit.get(context).users[index], context: context),
                      separatorBuilder: (context, index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey[350],
                            height: 1,
                            width: double.infinity,
                          ),
                      itemCount: SocialCubit.get(context).users.length),
                );
        });
  }

  Widget buildChatItem({required SocialUserModel model,required context}) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Text(
                '${model.name}',
              ),
            ],
          ),
        ),
      );
}
