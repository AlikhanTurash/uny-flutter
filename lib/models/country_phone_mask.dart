import 'package:equatable/equatable.dart';

class CountryPhoneMask with EquatableMixin {
  final String countryName;
  final String abbreviation;
  final String code;
  final String mask;
  final int digitsCount;

  const CountryPhoneMask({
    required this.countryName,
    required this.abbreviation,
    required this.code,
    required this.mask,
    required this.digitsCount,
  });

  @override
  List<Object?> get props => [countryName, abbreviation, code, mask, digitsCount];
}
