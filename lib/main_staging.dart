import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onspace/app/app.dart';
import 'package:onspace/bootstrap.dart';
import 'package:onspace/resources/constants/values.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: timeoutThreshold,
    sendTimeout: timeoutThreshold,
    receiveTimeout: timeoutThreshold,
    contentType: 'application/json',
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(() => const OnSpaceApp());
}
