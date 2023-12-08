import 'package:onspace/features/tag_location/data/data_provider/tags_location_data_provider.dart';
import 'package:onspace/features/tag_location/data/model/location_history.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';

class TagsLocationRepository {
  TagsLocationRepository({
    required TagsLocationDataProvider tagsLocationDataProvider,
  }) : _tagsLocationDataProvider = tagsLocationDataProvider;
  final TagsLocationDataProvider _tagsLocationDataProvider;

  // fetch tags location
  Future<List<Profile>> fetchTagsLocation() async {
    final response = await _tagsLocationDataProvider.fetchTagsLocationRequest()
        as List<dynamic>;
    final tagsLocation = List<Profile>.from(
      response.map(
        (e) => Profile.fromJson(e as Map<String, dynamic>),
      ),
    );
    return tagsLocation;
  }

  // fetch tags location history
  Future<List<LocationHistory>> fetchTagsLocationHistory() async {
    final response = await _tagsLocationDataProvider
        .fetchTagsLocationHistoryRequest() as List<dynamic>;
    final tagsLocationHistory = List<LocationHistory>.from(
      response.map(
        (e) => LocationHistory.fromJson(e as Map<String, dynamic>),
      ),
    );
    return tagsLocationHistory;
  }
}
