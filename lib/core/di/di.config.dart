// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../api_service.dart/api_service.dart' as _i66;
import '../navigation_service/navservice.dart' as _i697;
import '../theme/theme_cubit.dart' as _i611;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i697.NavigationService>(() => _i697.NavigationService());
    gh.lazySingleton<_i611.ThemeCubit>(() => _i611.ThemeCubit());
    gh.lazySingleton<_i66.OpenRouterService>(() => _i66.OpenRouterService(
          apiKey: gh<String>(),
          siteUrl: gh<String>(),
          siteName: gh<String>(),
        ));
    gh.lazySingleton<_i66.ScheduleGeneratorService>(
        () => _i66.ScheduleGeneratorService(gh<_i66.OpenRouterService>()));
    return this;
  }
}
