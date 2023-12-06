import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:onspace/features/tag_location/data/model/profile.dart';

import '../data/repository/tags_location_history.dart';

part 'tag_location_state.dart';

class TagLocationCubit extends Cubit<TagLocationState> {
  TagLocationCubit({required TagsLocationHistory tagsLocationHistory}) :
        _tagsLocationHistory = tagsLocationHistory, super(TagLocationInitial()){
    fetchTagsLocation();
  }
  final TagsLocationHistory _tagsLocationHistory;
  // Map<Marker, Profile> markers = {};

  Future<void> fetchTagsLocation() async{
    try{
      emit(TagsLocationLoading());
      final tagsLocation = await _tagsLocationHistory.fetchTagsLocation();
      emit(TagsLocationLoaded(tagsLocation: tagsLocation));
    }
    catch(e){
      emit(TagsLocationError(errorMessage: e.toString()));
    }
  }

//   // clear up markers with an empty set
//   clearMarkers() {
//     markers = {};
//   }
//
// //  add a single marker to a map
//   addMarker(BuildContext context, Profile profile) async {
//     final Uint8List icon =
//     await getBytesFromAssets('assets/images/rider.png', 100);
//     markers.putIfAbsent(
//         Marker(
//             markerId: MarkerId('${profile.userId}'),
//             position:
//             profile.location == null ? LatLng(0.0, 0.0) :
//             LatLng(profile.location?.latitude == null ? 0 : profile.location!.latitude!,
//                 profile.location?.longitude == null ? 0 : profile.location!.longitude!),
//             infoWindow: InfoWindow(
//                 title: "${profile.name}",
//                 snippet: "Tap for more details",
//                 onTap: () {
//                   print('a location icon has been pressed.');
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreens(userId: '${profile.userId}')));
//                 }),
//             icon: BitmapDescriptor.fromBytes(icon)),
//             () => profile);
//
//     markers = markers;
//   }
}
// Future<Uint8List?> getBytesFromAssets(String path, int width) async {
//   ByteData data = await rootBundle.load(path);
//   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//       targetWidth: width);
//   ui.FrameInfo fi = await codec.getNextFrame();
//   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
//       ?.buffer
//       .asUint8List();
// }
