import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/input_field.dart';
import '../../models/balance.dart';

const _appBarTitle = 'Receive Deposit';
const _labelInputValue = 'Deposit Value';
const _hintInputValue = '0.00';
const _labelButtonSend = 'Receive';

class ReceiveForm extends StatefulWidget {
  @override
  _ReceiveFormState createState() => _ReceiveFormState();
}

class _ReceiveFormState extends State<ReceiveForm> {
  TextEditingController _receivedValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputField(
              controller: _receivedValueController,
              icon: Icons.monetization_on_outlined,
              label: _labelInputValue,
              hint: _hintInputValue,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text(_labelButtonSend),
                onPressed: () => _receiveDeposit(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _receiveDeposit(BuildContext context) {
    double receivedValue = double.tryParse(_receivedValueController.text);

    if (_validateDeposit(receivedValue)) {
      _updateState(context, receivedValue);
      Navigator.pop(context);
    }
  }

  bool _validateDeposit(double value) {
    return value != null && value > 0;
  }

  void _updateState(BuildContext context, double value) {
    Provider.of<Balance>(context, listen: false).add(value);
  }
}
