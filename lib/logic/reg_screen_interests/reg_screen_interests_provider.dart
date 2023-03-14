import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:unyapp/models/interest.dart';

class RegScreenInterestsProvider extends ChangeNotifier {
  // Все интересы по всем категориям
  final List<Interest> _allInterests = [];
  bool _allInterestsWereSet = false;

  bool _tooltipWasShown = false;

  int _curCategoryId = 0;
  String _searchString = '';

  List<Interest> _selectedInterests = [];

  //---
  // Геттеры
  UnmodifiableListView<Interest> get allInterests => UnmodifiableListView(_allInterests);
  UnmodifiableListView<Interest> get selectedInterests => UnmodifiableListView(_selectedInterests);
  int get curCategoryId => _curCategoryId;
  String get searchString => _searchString;

  // ignore: unnecessary_getters_setters
  bool get tooltipWasShown => _tooltipWasShown;
  set tooltipWasShown(bool value) => _tooltipWasShown = value;

  //---------

  void allInterestsInitialization(List<Interest> interests) {
    if (!_allInterestsWereSet) {
      _allInterests.clear();
      _allInterests.addAll(interests);
      _curCategoryId = 1;
      _allInterestsWereSet = true;
      Future.delayed(const Duration(milliseconds: 50), () => notifyListeners());
    }
  }

  void addInterestToSelected(int interestId) {
    // если он есть, то return
    final index = _selectedInterests.indexWhere((el) => (el.id == interestId));
    if (index >= 0) return;
    final interestIndex = _allInterests.indexWhere((el) => (el.id == interestId));
    if (interestIndex < 0) return;

    _selectedInterests = [..._selectedInterests, _allInterests[interestIndex]];
    notifyListeners();
  }

  void deleteInterestFromSelected(int interestId) {
    // если его нет в выбранных, то return
    final index = _selectedInterests.indexWhere((el) => (el.id == interestId));
    if (index < 0) return;
    _selectedInterests = [
      ..._selectedInterests.sublist(0, index),
      ..._selectedInterests.sublist(index + 1)
    ];
    notifyListeners();
  }

  void setCurCategoryId(int categoryId) {
    _curCategoryId = categoryId;
    notifyListeners();
  }

  void setSearchString(String value) {
    if (value.trim().toLowerCase() != _searchString.trim().toLowerCase()) {
      _searchString = value.trim().toLowerCase();
      notifyListeners();
    }
  }
}
