import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../data/models/preferences_model/preferences_model.dart';

class PreferencesMultiselect extends StatelessWidget {
  const PreferencesMultiselect({
    super.key,
    required this.onAdd,
    required this.onDelete,
    required this.items,
    required this.selectedItems,
  });
  final void Function(PreferencesModel) onAdd;
  final void Function(PreferencesModel) onDelete;
  final List<PreferencesModel> items;
  final List<PreferencesModel> selectedItems;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 28),
              child: MultiDropdown<PreferencesModel>(
                items: items.map(
                  (item) {
                    return DropdownItem<PreferencesModel>(
                      label: item.name ?? "",
                      value: item,
                    );
                  },
                ).toList(),
                itemBuilder: (item, index, onTap) {
                  return ListTile(
                    title: Text(item.label),
                    onTap: () {
                      onAdd.call(item.value);
                    },
                  );
                },
                chipDecoration: const ChipDecoration(
                  backgroundColor: AppColors.darkBlue,
                  wrap: true,
                  runSpacing: 2,
                  spacing: 10,
                ),
                fieldDecoration: FieldDecoration(
                  hintText: 'Preferences',
                  backgroundColor: Colors.grey[100],
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                dropdownDecoration: const DropdownDecoration(maxHeight: 250),
              ),
            ),
          ),
          Wrap(
            children: selectedItems
                .map((item) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: Chip(
                        color: WidgetStatePropertyAll(AppColors.darkBlue),
                        label: Text(item.name ?? "",
                            style: TextStyle(color: AppColors.white)),
                        deleteIcon: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.white,
                        ),
                        onDeleted: () {
                          onDelete.call(item);
                        },
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
