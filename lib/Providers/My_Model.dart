import 'package:flutter/cupertino.dart';

class MyModel extends ChangeNotifier {
  int _counter = 1;
  int get counter => _counter;
  MyModel(this._counter);
  void increment() {
    _counter++;
    notifyListeners();
  }
}
