import 'package:flutter/cupertino.dart';

import '../styles/app_color.dart';

class GbAdminSwitch extends StatefulWidget {
  const GbAdminSwitch({super.key});

  @override
  State<GbAdminSwitch> createState() => _GbAdminSwitchState();
}

class _GbAdminSwitchState extends State<GbAdminSwitch> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isEnabled,
      onChanged: (value) {
        setState(() {
          isEnabled = value;
        });
      },
      activeTrackColor: AppColors.lightBlue,
    );
  }
}
