import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  T? getBloc<T extends StateStreamableSource<Object>>() {
    try {
      return BlocProvider.of<T>(this);
    } catch (_) {
      return null;
    }
  }
}
