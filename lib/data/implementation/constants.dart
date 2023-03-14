import 'package:dio/dio.dart';

final kDioOptions = BaseOptions(
  //baseUrl: 'http://224635.fornex.cloud/',
  //baseUrl: 'http://5.187.2.62:88/',
  baseUrl: 'https://5.187.3.129/',

  responseType: ResponseType.json,
  connectTimeout: 3500,
  receiveTimeout: 3500,
  headers: {
    'content-Type': 'application/json',
    'Accept': 'application/json',
    'Connection': 'keep-alive',
  },
  followRedirects: false,
);
