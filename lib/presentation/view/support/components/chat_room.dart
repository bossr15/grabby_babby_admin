import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_images.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/presentation/logic/support/support_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/support/support_state.dart';
import '../../../../core/styles/app_color.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/app_indicator.dart';
import '../../../../core/widgets/jumping_dots.dart';
import 'message/my_message.dart';
import 'message/other_message.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportCubit, SupportState>(builder: (context, state) {
      final cubit = context.read<SupportCubit>();
      final isScrolling = state.isMessagesScrolling;
      final isLoading = state.isMessagesLoading && !isScrolling;
      final messages = state.messages.getCachedData();
      final isEmpty = messages.isEmpty;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: isLoading
              ? [
                  Expanded(
                      child: Row(
                    children: [
                      Spacer(),
                      JumpingDots(),
                      Spacer(),
                    ],
                  ))
                ]
              : [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xff2563eb).withOpacity(0.37),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(AppImages.dummyUser),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.selectedChat.user.fullName ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                  if (state.isMessagesScrolling)
                    AppIndicator(color: AppColors.darkBlue),
                  Expanded(
                    child: isEmpty
                        ? Center(
                            child: Text("No Messages Found"),
                          )
                        : ListView.builder(
                            reverse: true,
                            controller: cubit.messagesScrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              bool isMe = message.senderId == cubit.userId;

                              return isMe
                                  ? MyMessage(message: message)
                                  : OtherMessage(message: message);
                            }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: context.width * 0.45,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  focusNode:
                                      getFieldFocusNode(cubit.sendMessage),
                                  // textInputAction: TextInputAction.newline,
                                  maxLines: 3,
                                  minLines: 1,
                                  onChanged: (val) {
                                    state.textController.text = val;
                                  },
                                  controller: state.textController,
                                  decoration: InputDecoration(
                                    hintText: 'Type your message...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.sendMessage();
                                },
                                child: Image.asset(AppImages.send),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
        ),
      );
    });
  }
}
