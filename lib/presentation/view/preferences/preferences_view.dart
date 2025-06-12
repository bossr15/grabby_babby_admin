import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import 'package:grabby_babby_admin/data/models/preferences_model/preferences_model.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/navigation/route_name.dart';

import '../../../core/styles/app_color.dart';
import '../../logic/preferences/preferences_cubit.dart';
import '../../logic/preferences/preferences_state.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferencesCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<PreferencesCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Preferences',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Manage category preferences across the platform',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await AppNavigation.pushNamedWithResult(
                            RouteName.addPreferences);
                        if (result == true && context.mounted) {
                          cubit.getPreferences();
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
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                          Gap(8),
                          const Text(
                            'Add Preferences',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                  ],
                ),
                Gap(24),
                Expanded(
                  child: BlocBuilder<PreferencesCubit, PreferencesState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: AppIndicator(color: AppColors.darkBlue),
                        );
                      }
                      if (state.preferences.isEmpty) {
                        return const Center(
                          child: Text("No Preferences available"),
                        );
                      }

                      return ResponsiveGrid(
                        items: state.preferences,
                        itemBuilder: (context, preference) {
                          return PreferenceCard(
                            preference: preference,
                            cubit: cubit,
                          );
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
  final List<PreferencesModel> items;
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
            childAspectRatio: 2.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
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

class PreferenceCard extends StatelessWidget {
  final PreferencesModel preference;
  final PreferencesCubit cubit;

  const PreferenceCard({
    super.key,
    required this.preference,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightBlue.withOpacity(0.1), AppColors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBlue.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final result = await AppNavigation.pushNamedWithResult(
                  RouteName.editPreferences,
                  pathParameters: {'id': preference.id?.toString() ?? ""});
              if (result == true && context.mounted) {
                cubit.getPreferences();
              }
            },
            splashColor: AppColors.lightBlue.withOpacity(0.1),
            highlightColor: AppColors.lightBlue.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:
                          preference.url != null && preference.url!.isNotEmpty
                              ? Image.network(
                                  preference.url!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: AppColors.grey,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.lightBlue,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.category_outlined,
                                  color: AppColors.darkBlue,
                                ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          preference.name ?? "Unnamed Category",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${preference.subPreferences?.length ?? 0} subcategories",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
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
