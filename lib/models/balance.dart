import 'package:flutter/material.dart';

class Balance extends ChangeNotifier {
  double _value;

  Balance(this._value);

  double get value => this._value;

  void add(double value) {
    this._value += value;
    notifyListeners();
  }

  void sub(double value) {
    this._value -= value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $_value';
  }
}
