import 'package:dio/dio.dart';

class TagsLocationDataProvider{

  TagsLocationDataProvider({required Dio dio}) : _dio = dio;
  final Dio _dio;

  // fetch tags location request
  Future<dynamic> fetchTagsLocationRequest() async{
    const tagsUrl = 'https://run.mocky.io/v3/8b7e8c6f-9f7e-4e0e-8b0e-9e9e1a2b2f1e';
    final response = await _dio.get(tagsUrl);
    return response;
  }

  // fetch tags location history request
  Future<dynamic> fetchTagsLocationHistoryRequest() async{
    const tagsUrl = 'https://run.mocky.io/v3/8b7e8c6f-9f7e-4e0e-8b0e-9e9e1a2b2f1e';
    final response = await _dio.get(tagsUrl);
    return response;
  }
}