import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onspace/app/app.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_history_cubit.dart';
import 'package:onspace/features/home/ui/screens/home_screen.dart';
import 'package:onspace/features/profile/cubit/tag_location_history_cubit.dart';
import 'package:onspace/features/tag_location/cubit/markers_cubit.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';

import '../cubit/mocked_cubits.dart';

void main() {
  group('App', () {
    late BottomNavigationBarCubit bottomNavigationBarCubit;
    late BottomNavigationHistoryCubit bottomNavigationHistoryCubit;
    late MarkersCubit markersCubit;
    late TagLocationCubit tagLocationCubit;
    late TagLocationHistoryCubit tagLocationHistoryCubit;

    setUp(() {
      bottomNavigationBarCubit = MockBottomNavigationCubit();
      bottomNavigationHistoryCubit = MockBottomNavigationHistoryCubit();
      markersCubit = MockMarkersCubit();
      tagLocationCubit = MockTagLocationCubit();
      tagLocationHistoryCubit = MockTagLocationHistoryCubit();
    });

    testWidgets('App view test', (tester) async {
      when(() => bottomNavigationBarCubit.state).thenReturn(0);
      when(() => bottomNavigationHistoryCubit.state).thenReturn([0]);
      when(() => markersCubit.state).thenReturn([]);
      when(() => tagLocationCubit.state).thenReturn(TagLocationInitial());
      when(() => tagLocationHistoryCubit.state)
          .thenReturn(TagLocationHistoryInitial());

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: bottomNavigationBarCubit),
            BlocProvider.value(value: bottomNavigationHistoryCubit),
            BlocProvider.value(value: markersCubit),
            BlocProvider.value(value: tagLocationCubit),
            BlocProvider.value(value: tagLocationHistoryCubit),
          ],
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      // the first screen has a bottom navigation bar
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}
