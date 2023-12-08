import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_history_cubit.dart';
import 'package:onspace/features/home/ui/screens/home_screen.dart';
import 'package:onspace/features/profile/cubit/tag_location_history_cubit.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';
import 'package:onspace/features/tag_location/data/data_provider/tags_location_data_provider.dart';
import 'package:onspace/features/tag_location/data/repository/tags_location_history.dart';
import 'package:onspace/l10n/l10n.dart';
import 'package:onspace/map/custom_markers_widget.dart';
import 'package:onspace/map/d.dart';
import 'package:onspace/map/fd.dart';
import 'package:onspace/resources/constants/app_colors.dart';

import '../../features/tag_location/cubit/markers_cubit.dart';
import '../../features/tag_location/cubit/markers_cubit.dart';
import '../../main_development.dart';
import '../../map/l.dart';

class OnSpaceApp extends StatelessWidget {
  const OnSpaceApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => BottomNavigationBarCubit()),
      BlocProvider(create: (_) => BottomNavigationHistoryCubit()),
      BlocProvider(create: (_) => MarkersCubit()),
      BlocProvider(
          create: (_) => TagLocationCubit(
              tagsLocationRepository: TagsLocationRepository(
                  tagsLocationDataProvider: TagsLocationDataProvider(dio: dio)))),
      BlocProvider(
          create: (_) => TagLocationHistoryCubit(
              tagsLocationHistory: TagsLocationRepository(
                  tagsLocationDataProvider: TagsLocationDataProvider(dio: dio)))),
    ], child: const OnSpaceAppView(),);
  }
}

class OnSpaceAppView extends StatelessWidget {
  const OnSpaceAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        hintColor: AppColors.greyColor,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.tertiaryColor,
            background: AppColors.backgroundWhiteColor,
            onBackground: AppColors.blackColor,
            primary: AppColors.primaryColor,
            onPrimary: AppColors.whiteColor,
            secondary: AppColors.secondaryColor,
            onSecondary: AppColors.blackColor,
            tertiary: AppColors.tertiaryColor,
            onTertiary: AppColors.whiteColor,
          error: AppColors.redColor,
          onError: AppColors.whiteColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      // home: MapWithCustomMarkers(),
      home: const HomeScreen(),
    );
  }
}

