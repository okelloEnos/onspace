import 'package:json_annotation/json_annotation.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
part 'location_history.g.dart';

@JsonSerializable()
class LocationHistory {
  LocationHistory({
    this.userId,
    this.locationHistory,
  });

  factory LocationHistory.fromJson(Map<String, dynamic> json) =>
      _$LocationHistoryFromJson(json);
  String? userId;
  List<LocationDetail>? locationHistory;

  Map<String, dynamic> toJson() => _$LocationHistoryToJson(this);
}
