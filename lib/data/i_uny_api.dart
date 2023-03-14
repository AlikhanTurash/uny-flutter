import 'dart:ui';

import 'package:unyapp/models/gender.dart';
import 'package:unyapp/models/interest.dart';

import '../models/photo.dart';

abstract class IUnyApi {
  // Посылаем на сервер номер телефона
  // После чего на телефон должна прийти sms-ка с кодом
  Future<void> auth(String countryCode, String phone);

  // Отправка на сервер кода из sms
  // В ответ получаем json c данными пользователя
  Future<Map<String, dynamic>> login(
      String countryCode, String phone, String smsCode);

  // Установка токена авторизации для использования
  // во всех дальнейших запросах к серверу
  void setToken(String token);

  // Обновление данных пользователя
  Future<void> updateUser({
    String? firstName,
    String? lastName,
    Gender? gender,
    DateTime? dateOfBirth,
    bool? showZodiacSign,
    String? location,
  });

  // Запрос интересов в категории
  Future<List<Interest>> fetchInterests(int categoryId);

  // Добавление интереса пользователю
  Future<bool> addInterestToUser(int interestId);

  // Удаление интереса у пользователя
  Future<bool> deleteInterestFromUser(int interestId);

  // Получение всех фотографий
  Future<List<Photo>> fetchPhotos();

  // Добавление фотографии при регистрации
  Future<bool> addPhotoToUser(Image photo, int main);

  // Удаление фотографии при регистрации
  Future<bool> deletePhotoFromUser(int photoId);

  //Перемещение фотографии при регистрации
  Future<bool> changePhotoPosition(
      int fromPhotoId, int toPhotoId, Image mainPhoto);
}
