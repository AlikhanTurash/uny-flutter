import 'package:unyapp/models/country_phone_mask.dart';

const kCountryPhoneMasks = [
  CountryPhoneMask(
    countryName: 'Россия',
    abbreviation: 'RU',
    code: '+7',
    mask: '(000) 000-00-00',
    digitsCount: 10,
  ),
  CountryPhoneMask(
    countryName: 'Украина',
    abbreviation: 'UA',
    code: '+380',
    mask: '(00) 000-00-00',
    digitsCount: 9,
  ),
  CountryPhoneMask(
    countryName: 'Казахстан',
    abbreviation: 'KZ',
    code: '+7',
    mask: '(000) 000-00-00',
    digitsCount: 10,
  ),
  CountryPhoneMask(
    countryName: 'Беларусь',
    abbreviation: 'BY',
    code: '+375',
    mask: '(00) 000-00-00',
    digitsCount: 9,
  ),
  CountryPhoneMask(
    countryName: 'Грузия',
    abbreviation: 'GE',
    code: '+995',
    mask: '(000) 00-00-00',
    digitsCount: 9,
  ),
  CountryPhoneMask(
    countryName: 'Армения',
    abbreviation: 'AM',
    code: '+374',
    mask: '(00) 000-000',
    digitsCount: 8,
  ),
];
