import 'package:flutter/foundation.dart';

import '../models/word_card.dart';

class HomeShellViewModel extends ChangeNotifier {
  int _selectedIndex = 1;
  WordCategory? _packFilter;

  int get selectedIndex => _selectedIndex;

  WordCategory? get packFilter => _packFilter;

  void selectTab(int index) {
    if (index == _selectedIndex) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void setPackFilter(WordCategory? category) {
    if (category == _packFilter) return;
    _packFilter = category;
    notifyListeners();
  }
}
