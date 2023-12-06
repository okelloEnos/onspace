import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {

  Profile({
    this.userId,
    this.name,
    this.category,
    this.avatar,
    this.location,
  });


  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  String? userId;
  String? name;
  String? category;
  String? avatar;
  Location? location;

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Location {

  Location({
    this.latitude,
    this.longitude,
    this.street,
    this.updatedOn,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  double? latitude;
  double? longitude;
  String? street;
  DateTime? updatedOn;

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
