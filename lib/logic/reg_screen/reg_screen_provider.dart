import 'package:flutter/foundation.dart';
import 'package:unyapp/data/constants.dart';
import 'package:unyapp/models/country_phone_mask.dart';

class RegScreenProvider extends ChangeNotifier {
  CountryPhoneMask _countryPhoneMask = kCountryPhoneMasks[0];
  String _phone = '';
  bool _isPhoneValid = true;
  String _phoneValidationMessage = '';
  String _smsCode = '';
  bool _isSmsCodeWrong = false;

  String _firstName = '';
  String _lastName = '';
  DateTime? _dateOfBirth;
  bool _isFirstNameValid = true;
  bool _isLastNameValid = true;
  bool _isDateOfBirthValid = true;
  String _mainInfoValidationMessage = '';

  String _location = '';
  bool _isLocationValid = true;
  String _locationValidationMessage = '';

  //---
  // Геттеры
  CountryPhoneMask get countryPhoneMask => _countryPhoneMask;
  String get phone => _phone;
  bool get isPhoneValid => _isPhoneValid;
  String get phoneValidationMessage => _phoneValidationMessage;
  String get smsCode => _smsCode;
  bool get isSmsCodeWrong => _isSmsCodeWrong;

  String get firstName => _firstName;
  String get lastName => _lastName;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool get isFirstNameValid => _isFirstNameValid;
  bool get isLastNameValid => _isLastNameValid;
  bool get isDateOfBirthValid => _isDateOfBirthValid;
  String get mainInfoValidationMessage => _mainInfoValidationMessage;

  String get location => _location;
  bool get isLocationValid => _isLocationValid;
  String get locationValidationMessage => _locationValidationMessage;

  //---
  // Сеттеры
  void setCountryPhoneMask(CountryPhoneMask value) => _countryPhoneMask = value;
  void setPhone(String value) => _phone = value;

  void setIsPhoneValid(bool value) {
    _isPhoneValid = value;
    notifyListeners();
  }

  void setPhoneValidationMessage(String value) {
    _phoneValidationMessage = value;
  }

  void setSmsCode(String value) {
    _smsCode = value;
    notifyListeners();
  }

  void setIsSmsCodeWrong(bool value) {
    _isSmsCodeWrong = value;
    notifyListeners();
  }

  void setFirstName(String value) => _firstName = value;
  void setLastName(String value) => _lastName = value;
  void setDateOfBirth(DateTime value) => _dateOfBirth = value;

  void setIsFirstNameValid(bool value) {
    _isFirstNameValid = value;
    notifyListeners();
  }

  void setIsLastNameValid(bool value) {
    _isLastNameValid = value;
    notifyListeners();
  }

  void setIsDateOfBirthValid(bool value) {
    _isDateOfBirthValid = value;
    notifyListeners();
  }

  void setMainInfoValidationMessage(String value) => _mainInfoValidationMessage = value;

  void setLocation(String value) => _location = value;
  void setLocationValidationMessage(String value) => _locationValidationMessage = value;
  void setIsLocationValid(bool value) {
    _isLocationValid = value;
    notifyListeners();
  }
}
