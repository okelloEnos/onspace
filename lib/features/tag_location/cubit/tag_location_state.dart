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
  final List<Profile> tagsLocation;

  TagsLocationLoaded({required this.tagsLocation});

  @override
  List<Object> get props => [tagsLocation];
}

class TagsLocationError extends TagLocationState {
  final String errorMessage;

  TagsLocationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
