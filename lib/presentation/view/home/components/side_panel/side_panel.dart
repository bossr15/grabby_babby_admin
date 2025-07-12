import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/navigation/route_name.dart';
import '../../../../../core/styles/app_color.dart';
import '../../../../../core/styles/app_images.dart';
import '../../../../logic/home/side_panel/side_panel_cubit.dart';
import '../../../../logic/home/side_panel/side_panel_state.dart';
import 'components/side_panel_item.dart';
import 'components/side_panel_item_widget.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final isDrawer = Scaffold.of(context).hasDrawer;
    return Container(
      width: isDrawer ? null : 350,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Builder(builder: (context) {
            final cubit = context.read<SidePanelCubit>();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  cubit.setSelectedIndex(0, context, RouteName.dashboard);
                },
                child: Row(
                  children: [
                    Image.asset(AppImages.logo),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aussie',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'Collectable',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 40),
          BlocBuilder<SidePanelCubit, SidePanelState>(
              builder: (context, state) {
            final cubit = context.read<SidePanelCubit>();
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  if (index == SidePanelItemList.sidePanelItems.length - 2 ||
                      index == 6) {
                    return Divider(
                      endIndent: 10,
                      indent: 10,
                      color: AppColors.grey,
                    );
                  }
                  return const SizedBox.shrink();
                },
                padding: EdgeInsets.zero,
                itemCount: SidePanelItemList.sidePanelItems.length,
                itemBuilder: (context, index) {
                  final item = SidePanelItemList.sidePanelItems[index];
                  return SidePanelItemWidget(
                    item: item,
                    isSelected: state.selectedIndex == index,
                    onTap: () {
                      cubit.setSelectedIndex(index, context, item.routeName);
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
