import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class TagsLocationDataProvider {
  TagsLocationDataProvider({required Dio dio}) : _dio = dio;
  final Dio _dio;

  // fetch tags location request
  Future<dynamic> fetchTagsLocationRequest() async {
    const tagsUrl = '/X7HK';
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return client;
    };

    final response = await _dio.get(tagsUrl);
    return response.data;
  }

  // fetch tags location history request
  Future<dynamic> fetchTagsLocationHistoryRequest() async {
    const tagsUrl = '/AYXV';
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return client;
    };
    final response = await _dio.get(tagsUrl);
    return response.data;
  }
}
