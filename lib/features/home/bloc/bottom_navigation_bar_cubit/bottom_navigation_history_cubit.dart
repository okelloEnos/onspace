import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationHistoryCubit extends Cubit<List<int>> {
  BottomNavigationHistoryCubit() : super([]);

  void updateTabHistory({required int index}) {
    state.add(index);
    emit(state);
  }
}
