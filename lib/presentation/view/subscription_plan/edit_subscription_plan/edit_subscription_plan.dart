import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_indicator.dart';
import '../../../../core/widgets/g_b_admin_button.dart';
import '../../../../core/widgets/gb_admin_dropdown.dart';
import '../../../logic/subscription_plan/edit_subscription_plan/edit_subscription_plan_cubit.dart';
import '../../../logic/subscription_plan/edit_subscription_plan/edit_subscription_plan_state.dart';
import '../../settings/components/account_settings/components/settings_text_field.dart';

class EditSubscriptionPlan extends StatelessWidget {
  final String id;
  const EditSubscriptionPlan({super.key, required this.id});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSubscriptionPlanCubit(planId: id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                AppBackButton(),
                const Gap(16),
                const Text(
                  'Update Plan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
            const Gap(24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<EditSubscriptionPlanCubit,
                    EditSubscriptionPlanState>(
                  builder: (context, state) {
                    final cubit = context.read<EditSubscriptionPlanCubit>();

                    return state.fetchingPlan
                        ? AppIndicator(color: AppColors.darkBlue)
                        : Padding(
                            padding: const EdgeInsets.all(24),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: SettingsTextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: state
                                                                .plan.title),
                                                    onChanged: (val) {
                                                      state.plan.title = val;
                                                    },
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return 'Please enter plan title';
                                                      }
                                                      if (val.length < 5 ||
                                                          val.length > 50) {
                                                        return 'Title must be between 5 and 50 characters';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'Title',
                                                    hintText:
                                                        'Please enter plan title',
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SettingsTextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: state
                                                                .plan.price
                                                                .toString()),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (val) {
                                                      state.plan.price =
                                                          double.tryParse(
                                                                  val) ??
                                                              0;
                                                    },
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return 'Please enter plan price';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'Price',
                                                    hintText:
                                                        'Please enter plan price',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: GbAdminDropdown(
                                                  label: "Intended for",
                                                  hintText: "Select a role",
                                                  items: ['SELLER', 'BUYER'],
                                                  value: state.plan.role,
                                                  onChanged:
                                                      (String? newValue) {
                                                    if (newValue != null) {
                                                      cubit.setUserRole(
                                                          newValue);
                                                    }
                                                  },
                                                )),
                                                Expanded(
                                                  child: SettingsTextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: state
                                                                .plan.duration
                                                                .toString()),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (val) {
                                                      state.plan.duration =
                                                          int.tryParse(val) ??
                                                              0;
                                                    },
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return 'Please enter plan duration in days';
                                                      }
                                                      if (int.tryParse(val) ==
                                                          null) {
                                                        return 'Please enter a valid number';
                                                      }
                                                      if (int.tryParse(val)! <
                                                          1) {
                                                        return 'Please enter a number greater than 0';
                                                      }
                                                      if (int.tryParse(val)! >
                                                          365) {
                                                        return 'Please enter a number less than 365';
                                                      }
                                                      if (int.tryParse(val)! %
                                                              1 !=
                                                          0) {
                                                        return 'Please enter a whole number';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'Duration In Days',
                                                    hintText:
                                                        'Please enter plan duration in days',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: SettingsTextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: state.plan
                                                                .description),
                                                    onChanged: (val) {
                                                      state.plan.description =
                                                          val;
                                                    },
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return 'Please enter plan description';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'Description',
                                                    hintText:
                                                        'Please enter plan description',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(24),
                                    Row(
                                      children: [
                                        GbAdminButton(
                                          label: 'Update Plan',
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.editPlan(context);
                                            }
                                          },
                                          widget: state.isLoading
                                              ? AppIndicator()
                                              : null,
                                          backgroundColor: AppColors.darkBlue,
                                          textColor: AppColors.white,
                                        ),
                                        SizedBox(width: 16),
                                        GbAdminButton(
                                          label: 'Reset',
                                          onPressed: () {
                                            cubit.resetState();
                                          },
                                          backgroundColor: AppColors.white,
                                          textColor: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
