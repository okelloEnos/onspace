import 'package:onspace/features/tag_location/data/data_provider/tags_location_data_provider.dart';
import 'package:onspace/features/tag_location/data/model/location_history.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';

class TagsLocationHistory{

  TagsLocationHistory({
    required TagsLocationDataProvider tagsLocationDataProvider,})
      : _tagsLocationDataProvider = tagsLocationDataProvider;
  final TagsLocationDataProvider _tagsLocationDataProvider;

  // fetch tags location
  Future<List<Profile>> fetchTagsLocation() async{
    var response = await _tagsLocationDataProvider.fetchTagsLocationRequest();
    List<dynamic> res = response.data as List<dynamic>;
    List<Profile> tagsLocation = List<Profile>.from(res.map((e) => Profile.fromJson(e as Map<String, dynamic>)));
    return tagsLocation;
  }

  // fetch tags location history
  Future<List<LocationHistory>> fetchTagsLocationHistory() async{
    final response = await _tagsLocationDataProvider
        .fetchTagsLocationHistoryRequest();
    List<dynamic> res = response.data as List<dynamic>;
    List<LocationHistory> tagsLocationHistory = List<LocationHistory>.from(res.map((e) =>
        LocationHistory.fromJson(e as Map<String, dynamic>)));
    return tagsLocationHistory;
  }
}