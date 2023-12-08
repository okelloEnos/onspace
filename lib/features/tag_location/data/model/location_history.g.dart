// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationHistory _$LocationHistoryFromJson(Map<String, dynamic> json) =>
    LocationHistory(
      userId: json['userId'] as String?,
      locationHistory: (json['locationHistory'] as List<dynamic>?)
          ?.map((e) => LocationDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationHistoryToJson(LocationHistory instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'locationHistory': instance.locationHistory,
    };
