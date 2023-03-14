import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/data/implementation/constants.dart';
import 'package:unyapp/models/gender.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/models/photo.dart';

class UnyApi implements IUnyApi {
  late final Dio _dio;

  UnyApi() {
    _dio = Dio(kDioOptions);
    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //     error: true,
    //     compact: true,
    //     //maxWidth: 90,
    //   ),
    // );
  }

  //-------
  @override
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  //-------
  @override
  Future<void> auth(String countryCode, String phone) async {
    try {
      await _dio.post(
        'api/auth',
        data: {
          'country_code_phone': countryCode,
          'phone': phone,
        },
      );
      return;
    } on DioError catch (e) {
      return Future.error(e.message.toString());
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<Map<String, dynamic>> login(
      String countryCode, String phone, String smsCode) async {
    try {
      final response = await _dio.post(
        'api/login',
        data: {
          'country_code_phone': countryCode,
          'phone': phone,
          'sms_key': smsCode,
        },
      );
      // Запоминаем токен
      setToken(response.data['data']['token']);
      return response.data['data'];
    } on DioError catch (e) {
      if ((e.response != null) && (e.response!.statusCode != null)) {
        return Future.error(e.response!.statusCode!);
      } else {
        return Future.error(e.message.toString());
      }
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<void> updateUser({
    String? firstName,
    String? lastName,
    Gender? gender,
    DateTime? dateOfBirth,
    bool? showZodiacSign,
    String? location,
  }) async {
    final Map<String, dynamic> params = {};
    if (firstName != null) {
      params['first_name'] = firstName;
    }
    if (lastName != null) {
      params['last_name'] = lastName;
    }
    if (gender != null) {
      params['gender'] = gender.name;
    }
    if (dateOfBirth != null) {
      params['date_of_birth'] = dateOfBirth;
    }
    if (showZodiacSign != null) {
      params['show_zodiac_sign'] = showZodiacSign.toString();
    }
    // location - обязательное поле
    // если будет null или пустая строка, то бэкенд ругнется
    if ((location == null) || (location.isEmpty)) {
      params['location'] = '-';
    } else {
      params['location'] = location;
    }

    try {
      await _dio.put('api/user/update', queryParameters: params);
      return;
    } on DioError catch (e) {
      return Future.error(e.message.toString());
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  void _setTempTokenForDebug() {
    final authToken = _dio.options.headers['Authorization'];
    if ((authToken == null) || (authToken.toString().trim() == '')) {
      _dio.options.headers['Authorization'] =
          'Bearer 7|eC24Tsaxid4RGI8yrZNWlqbmDk3yNNl86V8ZzCih';
    }
  }

  //-------
  @override
  Future<List<Interest>> fetchInterests(int categoryId) async {
    _setTempTokenForDebug();
    try {
      final response = await _dio.get(
        'api/interest',
        queryParameters: {'interest_category_id': categoryId},
      );
      final interestsJsonArr = response.data['data'] as List<dynamic>;
      final interests =
          interestsJsonArr.map((item) => Interest.fromJson(item)).toList();
      return interests;
    } on DioError catch (e) {
      return Future.error(e.message.toString());
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<bool> addInterestToUser(int interestId) async {
    _setTempTokenForDebug();
    try {
      await _dio.post(
        'api/interest/add-interest-to-user',
        queryParameters: {'interest_id': interestId},
      );
      print('Uni API:  add-interest-to-user ..... Ok!');
      return true;
    } on DioError catch (e) {
      if ((e.response != null) && (e.response!.statusCode != null)) {
        return Future.error(e.response!.statusCode!);
        //return Future.error('Error code: ${e.response!.statusCode!}');
      } else {
        return Future.error(e.message.toString());
      }
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<bool> deleteInterestFromUser(int interestId) async {
    _setTempTokenForDebug();
    try {
      await _dio.delete(
        'api/interest/delete-from-user',
        queryParameters: {'interest_id': interestId},
      );
      return true;
    } on DioError catch (e) {
      if ((e.response != null) && (e.response!.statusCode != null)) {
        return Future.error(e.response!.statusCode!);
        //return Future.error('Error code: ${e.response!.statusCode!}');
      } else {
        return Future.error(e.message.toString());
      }
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<List<Photo>> fetchPhotos() async {
    _setTempTokenForDebug();
    try {
      final response = await _dio.get(
        'api/user/media/photo/all',
      );
      final photosJsonArr = response.data['data'] as List<dynamic>;
      final photos = photosJsonArr.map((item) => Photo.fromJson(item)).toList();
      return photos;
    } on DioError catch (e) {
      return Future.error(e.message.toString());
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<bool> addPhotoToUser(
    Image photo,
    int main,
  ) async {
    _setTempTokenForDebug();
    try {
      await _dio.post(
        'api/interest/add-interest-to-user',
        queryParameters: {'photo': photo, 'main': main},
      );
      print('Uni API:  add-photo-to-user ..... Ok!');
      return true;
    } on DioError catch (e) {
      if ((e.response != null) && (e.response!.statusCode != null)) {
        return Future.error(e.response!.statusCode!);
        //return Future.error('Error code: ${e.response!.statusCode!}');
      } else {
        return Future.error(e.message.toString());
      }
    } catch (_) {
      return Future.error('Service error');
    }
  }

  //-------
  @override
  Future<bool> deletePhotoFromUser(int photoId) async {
    _setTempTokenForDebug();
    try {
      await _dio.delete(
        'api/user/media/photo/delete',
        queryParameters: {'id': photoId},
      );
      return true;
    } on DioError catch (e) {
      if ((e.response != null) && (e.response!.statusCode != null)) {
        return Future.error(e.response!.statusCode!);
      } else {
        return Future.error(e.message.toString());
      }
    } catch (_) {
      return Future.error('Service error');
    }
  }

  @override
  Future<bool> changePhotoPosition(
      int fromPhotoId, int toPhotoId, Image mainPhoto) async {
    _setTempTokenForDebug();
    try {
      await _dio.post(
        'api/interest/add-interest-to-user',
        queryParameters: {
          'from': fromPhotoId,
          'to': toPhotoId,
          'main_photo': mainPhoto
        },
      );
      print('Uni API:  change-user-photo ..... Ok!');
      return true;
    } on DioError catch (e) {
      if ((e.response != null) && (e.response!.statusCode != null)) {
        return Future.error(e.response!.statusCode!);
        //return Future.error('Error code: ${e.response!.statusCode!}');
      } else {
        return Future.error(e.message.toString());
      }
    } catch (_) {
      return Future.error('Service error');
    }
  }
}
