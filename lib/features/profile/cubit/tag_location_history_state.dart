part of 'tag_location_history_cubit.dart';

abstract class TagLocationHistoryState extends Equatable {
  const TagLocationHistoryState();
}

class TagLocationHistoryInitial extends TagLocationHistoryState {
  @override
  List<Object> get props => [];
}

class TagsLocationHistoryLoading extends TagLocationHistoryState {
  @override
  List<Object> get props => [];
}

class TagsLocationHistoryLoaded extends TagLocationHistoryState {
  final List<LocationHistory> tagsLocationHistory;

  TagsLocationHistoryLoaded({required this.tagsLocationHistory});

  @override
  List<Object> get props => [tagsLocationHistory];
}

class TagsLocationHistoryError extends TagLocationHistoryState {
  final String errorMessage;

  TagsLocationHistoryError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
