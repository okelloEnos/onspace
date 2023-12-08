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
  const TagsLocationHistoryLoaded({required this.tagsLocationHistory});
  final List<LocationDetail> tagsLocationHistory;

  @override
  List<Object> get props => [tagsLocationHistory];
}

class TagsLocationHistoryError extends TagLocationHistoryState {
  const TagsLocationHistoryError({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
