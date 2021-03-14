import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';

class Bioemetric extends StatelessWidget {
  final _auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isBiometricAvailabe(),
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Column(
              children: [
                Text(
                  'Detectamos que você tem sensor biométrico no seu dispositivo, deseja cadastrar o acesso biométrico?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: const Text('Autenticar Usando Biometria'),
                  onPressed: () {
                    _authenticateCustomer(context);
                  },
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<bool> _isBiometricAvailabe() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (error) {
      print(error);
      return false;
    }
  }

  Future<void> _authenticateCustomer(BuildContext context) async {
    bool authenticated = await _auth.authenticate(
      localizedReason: 'Bota a cara no sol querida!',
      biometricOnly: true,
      useErrorDialogs: true,
    );
    Provider.of<Customer>(context, listen: false).biometric = authenticated;
  }
}
