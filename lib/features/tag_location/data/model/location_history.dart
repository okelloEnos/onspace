import 'package:json_annotation/json_annotation.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
part 'location_history.g.dart';

@JsonSerializable()
class LocationHistory {
  String? userId;
  List<LocationDetail>? locationHistory;

  LocationHistory({
    this.userId,
    this.locationHistory,
  });

  factory LocationHistory.fromJson(Map<String, dynamic> json) =>
      _$LocationHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$LocationHistoryToJson(this);
}

