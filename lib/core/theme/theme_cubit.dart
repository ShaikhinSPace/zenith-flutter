import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:zenith/core/di/di.dart';
import 'package:zenith/core/navigation_service/navservice.dart';

@lazySingleton
class ThemeCubit extends Cubit<bool> {
  ThemeCubit()
    : super(
        getIt<NavigationService>().getNavigationContext() != null
            ? Theme.of(
                  getIt<NavigationService>().getNavigationContext()!,
                ).brightness ==
                Brightness.dark
            : false,
      );
  void changeTheme() {
    bool isDark = state;
    isDark = !isDark;
    emit(isDark);
  }
}
