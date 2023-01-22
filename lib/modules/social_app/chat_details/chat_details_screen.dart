import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/social_app/message_model.dart';
import '../../../models/social_app/user_model.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetailsScreen({super.key, required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userModel.image}'),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${userModel.name}',
                    ),
                  ],
                ),
              ),
              body: SocialCubit.get(context).messages.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).messages[index];
                                if (SocialCubit.get(context).userModel?.uId ==
                                    message.senderId) {
                                  return buildMyMessage(message);
                                } else {
                                  return buildMessage(message);
                                }
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount:
                                  SocialCubit.get(context).messages.length,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadiusDirectional.circular(15)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                          hintText: 'write your message here..',
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: defaultColor,
                                  height: 50,
                                  child: MaterialButton(
                                    minWidth: 1,
                                    onPressed: () {
                                      SocialCubit.get(context).sendMessage(
                                        receiverId: userModel.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                    },
                                    child: const Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            );
          });
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
              color: Colors.grey[300]),
          child: Text(model.text!),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
            color: defaultColor.withOpacity(0.25),
          ),
          child: Text(model.text!),
        ),
      );
}
