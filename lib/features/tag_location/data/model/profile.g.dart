// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      avatar: json['avatar'] as String?,
      location: json['location'] == null
          ? null
          : LocationDetail.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'category': instance.category,
      'avatar': instance.avatar,
      'location': instance.location,
    };

LocationDetail _$LocationDetailFromJson(Map<String, dynamic> json) =>
    LocationDetail(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      street: json['street'] as String?,
      updatedOn: json['updatedOn'] == null
          ? null
          : DateTime.parse(json['updatedOn'] as String),
    );

Map<String, dynamic> _$LocationDetailToJson(LocationDetail instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'street': instance.street,
      'updatedOn': instance.updatedOn?.toIso8601String(),
    };
