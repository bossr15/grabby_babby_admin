import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grabby_babby_admin/presentation/logic/subscription_plan/add_subscription_plan/add_subscription_plan_cubit.dart';
import 'package:grabby_babby_admin/presentation/view/settings/components/account_settings/components/settings_text_field.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_indicator.dart';
import '../../../../core/widgets/g_b_admin_button.dart';
import '../../../logic/subscription_plan/add_subscription_plan/add_subscription_plan_state.dart';

class AddSubscriptionPlan extends StatelessWidget {
  const AddSubscriptionPlan({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSubscriptionPlanCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                AppBackButton(),
                const Gap(16),
                const Text(
                  'Add Plan',
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
                child: BlocBuilder<AddSubscriptionPlanCubit,
                    AddSubscriptionPlanState>(
                  builder: (context, state) {
                    final cubit = context.read<AddSubscriptionPlanCubit>();

                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SettingsTextField(
                                      onChanged: (val) {
                                        state.plan.title = val;
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter plan title';
                                        }
                                        return null;
                                      },
                                      label: 'Title',
                                      hintText: 'Please enter plan title',
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: SettingsTextField(
                                      onChanged: (val) {
                                        state.plan.description = val;
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter plan description';
                                        }
                                        return null;
                                      },
                                      label: 'Description',
                                      hintText: 'Please enter plan description',
                                    ),
                                  ),
                                  Gap(10),
                                ],
                              ),
                              Gap(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SettingsTextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) {
                                        state.plan.price =
                                            double.tryParse(val) ?? 0;
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter plan price';
                                        }
                                        return null;
                                      },
                                      label: 'Price',
                                      hintText: 'Please enter plan price',
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: SettingsTextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) {
                                        state.plan.duration =
                                            int.tryParse(val) ?? 0;
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter plan duration in days';
                                        }
                                        if (int.tryParse(val) == null) {
                                          return 'Please enter a valid number';
                                        }
                                        if (int.tryParse(val)! < 1) {
                                          return 'Please enter a number greater than 0';
                                        }
                                        if (int.tryParse(val)! > 365) {
                                          return 'Please enter a number less than 365';
                                        }
                                        if (int.tryParse(val)! % 1 != 0) {
                                          return 'Please enter a whole number';
                                        }
                                        return null;
                                      },
                                      label: 'Duration In Days',
                                      hintText:
                                          'Please enter plan duration in days',
                                    ),
                                  ),
                                  Gap(10),
                                ],
                              ),
                              Gap(24),
                              Row(
                                children: [
                                  GbAdminButton(
                                    label: 'Add Plan',
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.addPreferences(context);
                                      }
                                    },
                                    widget:
                                        state.isLoading ? AppIndicator() : null,
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
