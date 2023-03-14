import 'package:age_calculator/age_calculator.dart';

String onlyDigitsPhone(String phone) {
  return phone.replaceAll(RegExp(r"[^\s\w]"), '').replaceAll(' ', '');
}

String validatePhone(String phone, int digitsCount) {
  if (onlyDigitsPhone(phone).length != digitsCount) {
    return 'Телефон должен содержать $digitsCount цифр';
  }
  // Validation success
  return '';
}

String validateFirstName(String firstName) {
  if (firstName.isEmpty) {
    return 'Введи имя';
  }
  if (firstName.length < 2) {
    return 'Имя - минимум 2 символа';
  }
  // Validation success
  return '';
}

String validateLastName(String lastName) {
  if (lastName.isEmpty) {
    return 'Введи фамилию';
  }
  if (lastName.length < 2) {
    return 'Фамилия - минимум 2 символа';
  }
  // Validation success
  return '';
}

String validateDateOfBirth(DateTime? dateOfBirth) {
  if (dateOfBirth == null) {
    return 'Введи дату рождения';
  }
  final age = AgeCalculator.age(dateOfBirth);
  if (age.years < 18) {
    return 'Возраст должен превышать 18 лет';
  }
  // Validation success
  return '';
}

String validateLocation(String location) {
  if (location.isEmpty) {
    return 'Введи местоположение';
  }
  if (location.length < 2) {
    return 'Местоположение - минимум 2 символа';
  }
  // Validation success
  return '';
}
