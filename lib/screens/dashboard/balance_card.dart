import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/balance.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<Balance>(
          builder: (context, value, child) {
            return Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}
