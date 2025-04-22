import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_cubit.dart';

import '../../../../../../core/utils/date_helpers.dart';
import '../../../../../logic/users_management/user_state.dart';

class UsersTabBarActions extends StatelessWidget {
  const UsersTabBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        return Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateHelpers.formatDateRange(
                          state.startDate, state.endDate),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () async {
                        final pickedRange =
                            await DateHelpers.showDateRange(context: context);
                        if (pickedRange != null) {
                          cubit.setDate(pickedRange);
                        }
                      },
                      child: Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 200,
                height: 45,
                child: TextFormField(
                  onChanged: (value) => cubit.searchUsers(value),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: Icon(
                      Icons.filter_list,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
