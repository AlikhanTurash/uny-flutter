import 'package:unyapp/main.dart';
import 'package:unyapp/models/gender.dart';
import 'package:unyapp/models/uny_user.dart';

// Создание глобального объекта unyUser (ПОЛЬЗОВАТЕЛЬ)

void createGlobalUnyUserFromJson(Map<String, dynamic> json) {
  Gender? userGender;
  try {
    userGender = Gender.values.byName(json['gender'].toString());
  } catch (_) {
    userGender = null;
  }

  unyUser = UnyUser(
    id: json['id'],
    firstName: json['first_name'] ?? '',
    lastName: json['last_name'] ?? '',
    countryCodePhone: json['country_code_phone'],
    phone: json['phone'],
    location: json['location'] ?? '',
    aboutMe: json['about_me'] ?? '',
    gender: userGender,
    dateOfBirth: DateTime.tryParse(json['date_of_birth'].toString()),
    //authCode: json['auth_code'],
    //whoCanSee: json['who_can_see'],
    job: json['job'] ?? '',
    jobCompany: json['job_company'] ?? '',
    //muteNotifications: json['mute_notifications'] ?? 0,
    //muteRequestMessagingNotifications: json['mute_request_messaging_notifications'] ?? 0,
    //muteMessagesNotifications: json['mute_messages_notifications'] ?? 0,
    //showZodiacSign: json['show_zodiac_sign'] ?? 1,
    //zodiacSign: json['zodiac_sign'],
    //unycoin: json['unycoin'] ?? 0,
    //createdAt: DateTime.parse(json['created_at'].toString()),
    //updatedAt: DateTime.parse(json['updated_at'].toString()),
    token: json['token'] ?? '',
  );
}
