import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:zenith/core/di/di.dart';
import 'package:zenith/core/theme/theme_cubit.dart';

interface class ICoreBlocProvider {
  List<SingleChildWidget> get globalBlocProvider => <SingleChildWidget>[
    BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
  ];
}

interface class IGlobalBlocProvider {
  List<SingleChildWidget> get globalBlocProvider => <SingleChildWidget>[
    ...ICoreBlocProvider().globalBlocProvider,
  ];
}

class GlobalBlocProvider extends IGlobalBlocProvider {}
