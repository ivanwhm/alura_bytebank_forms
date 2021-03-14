import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/balance.dart';
import 'models/customer.dart';
import 'models/transfers.dart';
import 'screens/auth/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Balance(0),
        ),
        ChangeNotifierProvider(
          create: (context) => Transfers(),
        ),
        ChangeNotifierProvider(
          create: (context) => Customer(),
        ),
      ],
      child: ByteBankApp(),
    ),
  );
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Color.fromRGBO(70, 161, 56, 1),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromRGBO(70, 161, 56, 1),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}
