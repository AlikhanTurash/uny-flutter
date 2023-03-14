// ignore_for_file: unnecessary_getters_setters
import 'package:unyapp/models/gender.dart';

// Тип для глобального объекта unyUser

class UnyUser {
  int _id;
  String _firstName;
  String _lastName;
  String _countryCodePhone;
  String _phone;
  String _location;
  String _aboutMe;
  Gender? _gender;
  DateTime? _dateOfBirth;
  String _job;
  String _jobCompany;
  // bool _muteNotifications;
  // bool _muteRequestMessagingNotifications;
  // bool _muteMessagesNotifications;
  // bool _showZodiacSign;
  // String zodiacSign,
  // int unycoin;
  // DateTime createdAt;
  // DateTime updatedAt;
  String _token;

  // Getters and setters
  int get id => _id;
  set id(int value) => _id = value;

  String get firstName => _firstName;
  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;
  set lastName(String value) => _lastName = value;

  String get countryCodePhone => _countryCodePhone;
  set countryCodePhone(String value) => _countryCodePhone = value;

  String get phone => _phone;
  set phone(String value) => _phone = value;

  String get location => _location;
  set location(String value) => _location = value;

  String get aboutMe => _aboutMe;
  set aboutMe(String value) => _aboutMe = value;

  Gender? get gender => _gender;
  set gender(Gender? value) => _gender = value;

  DateTime? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(DateTime? value) => _dateOfBirth = value;

  String get job => _job;
  set job(String value) => _job = value;

  String get jobCompany => _jobCompany;
  set jobCompany(String value) => _jobCompany = value;

  String get token => _token;
  set token(String value) => _token = value;

  // Constructor
  UnyUser({
    required int id,
    required String firstName,
    required String lastName,
    required String countryCodePhone,
    required String phone,
    required String location,
    required String aboutMe,
    required Gender? gender,
    required DateTime? dateOfBirth,
    required String job,
    required String jobCompany,
    // required muteNotifications,
    // required muteRequestMessagingNotifications,
    // required muteMessagesNotifications,
    // required showZodiacSign,
    // required zodiacSign,
    // required unycoin,
    // required createdAt,
    // required updatedAt,
    required String token,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _countryCodePhone = countryCodePhone,
        _phone = phone,
        _location = location,
        _aboutMe = aboutMe,
        _gender = gender,
        _dateOfBirth = dateOfBirth,
        _job = job,
        _jobCompany = jobCompany,
        _token = token;
}
