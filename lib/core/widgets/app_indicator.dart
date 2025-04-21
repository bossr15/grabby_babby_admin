import 'package:flutter/material.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator({super.key, this.color = Colors.white});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}
