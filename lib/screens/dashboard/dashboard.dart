import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../auth/login.dart';
import '../receive/form.dart';
import '../transfer/form.dart';
import '../transfer/latest.dart';
import 'balance_card.dart';

const _appBarTitle = 'ByteBank';
const _labelReceiveDepositButton = 'Receive Deposit';
const _labelSendTransferButton = 'Send Transfer';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (_) => Login(),
                fullscreenDialog: true,
              );
              Navigator.pushAndRemoveUntil(context, route, (_) => false);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Consumer<Customer>(
            builder: (context, customer, child) {
              if (customer.name != null) {
                return Text(
                  'Olá, ${customer.name.split(" ")[0]} o seu saldo de hoje é: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.center,
                );
              }
              return Text(
                'Olá, o seu saldo de hoje é: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          Align(
            child: BalanceCard(),
            alignment: Alignment.topCenter,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(_labelReceiveDepositButton),
                onPressed: () => _receiveDeposit(context),
              ),
              ElevatedButton(
                child: Text(_labelSendTransferButton),
                onPressed: () => _sendTransfer(context),
              ),
            ],
          ),
          LatestTransfers(),
        ],
      ),
    );
  }

  void _receiveDeposit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReceiveForm()),
    );
  }

  void _sendTransfer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransferForm()),
    );
  }
}
