import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import 'package:grabby_babby_admin/data/models/subscription_plan_model/subscription_plan_model.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/navigation/route_name.dart';

import '../../../core/styles/app_color.dart';
import '../../logic/subscription_plan/subscription_plan_cubit.dart';
import '../../logic/subscription_plan/subscription_plan_state.dart';

class SubscriptionPlanView extends StatelessWidget {
  const SubscriptionPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionPlanCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<SubscriptionPlanCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subscription Plans',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore and manage all subscription plans',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result = await AppNavigation.pushNamedWithResult(
                            RouteName.addSubscriptionPlan);
                        if (result == true && context.mounted) {
                          cubit.getPlans();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.white,
                      ),
                      label: const Text(
                        'Add Plan',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child:
                      BlocBuilder<SubscriptionPlanCubit, SubscriptionPlanState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: AppIndicator(color: AppColors.darkBlue),
                        );
                      }
                      if (state.plans.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Subscription Plans available",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ),
                        );
                      }
                      return ResponsiveGrid(
                        items: state.plans,
                        itemBuilder: (context, plan) {
                          return SubscriptionCard(preference: plan);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<SubscriptionPlanModel> items;
  final Widget Function(BuildContext, dynamic) itemBuilder;

  const ResponsiveGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);

        return GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) => itemBuilder(context, items[index]),
        );
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width > 1200) {
      return 4; // Extra large screens
    } else if (width > 900) {
      return 3; // Large screens
    } else if (width > 600) {
      return 2; // Medium screens
    } else {
      return 1; // Small screens
    }
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlanModel preference;

  const SubscriptionCard({
    super.key,
    required this.preference,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightBlue.withOpacity(0.2), AppColors.bgColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final result = await AppNavigation.pushNamedWithResult(
                  RouteName.editSubscriptionPlan,
                  pathParameters: {'id': preference.id?.toString() ?? ""});
              if (result == true && context.mounted) {
                context.read<SubscriptionPlanCubit>().getPlans();
              }
            },
            splashColor: AppColors.lightBlue.withOpacity(0.3),
            highlightColor: AppColors.lightBlue.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.darkBlue, AppColors.lightBlue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.monetization_on,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              preference.title ?? "Unnamed Plan",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              preference.description ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.grey.withOpacity(0.5)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${preference.duration ?? 0} days",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "\$${preference.price?.toStringAsFixed(2) ?? "0.00"}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.greenText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
