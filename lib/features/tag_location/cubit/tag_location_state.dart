part of 'tag_location_cubit.dart';

abstract class TagLocationState extends Equatable {
  const TagLocationState();
}

class TagLocationInitial extends TagLocationState {
  @override
  List<Object> get props => [];
}

class TagsLocationLoading extends TagLocationState {
  @override
  List<Object> get props => [];
}

class TagsLocationLoaded extends TagLocationState {
  const TagsLocationLoaded({required this.tagsLocation});
  final List<Profile> tagsLocation;

  @override
  List<Object> get props => [tagsLocation];
}

class TagsLocationError extends TagLocationState {
  const TagsLocationError({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
