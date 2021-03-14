import 'package:flutter/material.dart';

import 'transfer.dart';

class Transfers extends ChangeNotifier {
  final List<Transfer> _transfers = [];

  List<Transfer> get transfers => _transfers;

  void add(Transfer transfer) {
    _transfers.add(transfer);
    notifyListeners();
  }
}
