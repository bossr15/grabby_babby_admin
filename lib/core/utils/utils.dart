import 'package:flutter/material.dart';

import '../styles/app_color.dart';

LinearGradient appGradient = LinearGradient(
  colors: [AppColors.darkBlue, AppColors.lightBlue],
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
);

List<T> parseList<T>(
  data,
  T Function(Map<String, dynamic>) fromJson,
) {
  final parsedData = (data as List?)?.cast<Map<String, dynamic>>();
  return parsedData?.map(fromJson).toList().cast<T>() ?? [];
}
