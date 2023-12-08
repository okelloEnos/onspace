import 'package:bloc_test/bloc_test.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_history_cubit.dart';
import 'package:onspace/features/profile/cubit/tag_location_history_cubit.dart';
import 'package:onspace/features/tag_location/cubit/markers_cubit.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';

class MockBottomNavigationCubit
    extends MockCubit<int>
    implements BottomNavigationBarCubit {}

class MockBottomNavigationHistoryCubit
    extends MockCubit<List<int>>
    implements BottomNavigationHistoryCubit {}

class MockMarkersCubit
    extends MockCubit<List<MarkerData>>
    implements MarkersCubit {}

class MockTagLocationCubit
    extends MockCubit<TagLocationState>
    implements TagLocationCubit {
  @override
  TagsLocationFilter filter = TagsLocationFilter.all;

}

class MockTagLocationHistoryCubit
    extends MockCubit<TagLocationHistoryState>
    implements TagLocationHistoryCubit {}
