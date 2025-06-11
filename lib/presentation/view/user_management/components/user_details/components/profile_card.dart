import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/date_helpers.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import '../../../../../../core/styles/app_images.dart';
import '../../../../../../data/models/order_model/order_model.dart';
import '../../../../../logic/users_management/user_detail/user_detail_cubit.dart';
import '../../../../../logic/users_management/user_detail/user_detail_state.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailCubit, UserDetailState>(
      builder: (context, state) {
        final cubit = context.read<UserDetailCubit>();
        final user = cubit.user;
        return Container(
          constraints: BoxConstraints(maxHeight: context.height * 0.6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3d3d3d),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage(AppImages.coverImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(AppImages.dummyUser),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ID #${user.id?.toString() ?? ""}',
                              style: TextStyle(
                                color: Color(0xff7F7F7F),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: getStatusChipColor(user.status!),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: Text(
                              fromStatus(user.status!),
                              style: TextStyle(
                                color: getOrderChipTextColor(user.status!),
                              ),
                            )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Username', user.fullName ?? ""),
                    _buildInfoRow(
                        'Registration Date',
                        DateHelpers.formatDate(
                            user.createdAt ?? DateTime.now())),
                    _buildInfoRow('Phone Number', user.phoneNumber ?? ""),
                    _buildInfoRow('Email', user.email ?? ""),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
