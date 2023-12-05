import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onspace/counter/counter.dart';
import 'package:onspace/l10n/l10n.dart';

import '../../features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../../features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_history_cubit.dart';

class OnSpaceApp extends StatelessWidget {
  const OnSpaceApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => BottomNavigationBarCubit()),
      BlocProvider(create: (_) => BottomNavigationHistoryCubit()),
      // BlocProvider(
      //     create: (_) => LogInBloc(
      //         logInRepository: LogInRepository(
      //             logInRemoteDataProvider: LogInRemoteDataProvider(dio: dio)))),

    ], child: const OnSpaceAppView(),);
  }
}

class OnSpaceAppView extends StatelessWidget {
  const OnSpaceAppView({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}

