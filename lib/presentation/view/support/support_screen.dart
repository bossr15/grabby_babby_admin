import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import 'package:grabby_babby_admin/presentation/logic/support/support_cubit.dart';
import 'package:grabby_babby_admin/presentation/view/support/components/chat_room.dart';

import '../../logic/support/support_state.dart';
import 'components/chat_list.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SupportCubit>(
      create: (context) => SupportCubit(),
      child: BlocBuilder<SupportCubit, SupportState>(builder: (context, state) {
        final isLoading = state.isChatsLoading &&
            !state.isChatsScrolling &&
            !state.isChatsSearching &&
            state.selectedChat.id == 0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: isLoading
              ? AppIndicator(color: AppColors.darkBlue)
              : state.selectedChat.id == 0
                  ? Center(child: Text("No Chats Found"))
                  : Row(
                      children: [
                        Expanded(flex: 2, child: ChatRoom()),
                        const SizedBox(width: 12),
                        Expanded(child: ChatList()),
                      ],
                    ),
        );
      }),
    );
  }
}
