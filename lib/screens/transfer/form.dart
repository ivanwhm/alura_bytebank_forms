import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/input_field.dart';
import '../../models/balance.dart';
import '../../models/transfer.dart';
import '../../models/transfers.dart';

const _appBarTitle = 'New Transfer';
const _labelInputTargetAccount = 'Target Account';
const _hintInputTargetAccount = '0000-0';
const _labelInputValue = 'Transfer Value';
const _hintInputValue = '0.00';
const _labelButtonSend = 'Send';

class TransferForm extends StatelessWidget {
  final TextEditingController _targetAccountController = TextEditingController();
  final TextEditingController _transferValueController = TextEditingController();

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
              controller: _targetAccountController,
              icon: Icons.account_balance,
              label: _labelInputTargetAccount,
              hint: _hintInputTargetAccount,
              keyboardType: TextInputType.numberWithOptions(signed: true),
            ),
            InputField(
              controller: _transferValueController,
              icon: Icons.monetization_on_outlined,
              label: _labelInputValue,
              hint: _hintInputValue,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text(_labelButtonSend),
                onPressed: () => _sendTransfer(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendTransfer(BuildContext context) {
    double transferValue = double.tryParse(_transferValueController.text);
    String targetAccount = _targetAccountController.text;
    bool transferIsValid = _validateTransfer(context, transferValue, targetAccount);

    if (transferIsValid) {
      Transfer newTransfer = Transfer(transferValue, targetAccount);
      _updateState(context, newTransfer);
      Navigator.pop(context);
    }
  }

  bool _validateTransfer(BuildContext context, double transferValue, String targetAccount) {
    final isValid = (transferValue != null && transferValue > 0 && targetAccount != null);
    final currentBalance = Provider.of<Balance>(context, listen: false).value;
    final hasBalance = transferValue <= currentBalance;
    return isValid && hasBalance;
  }

  void _updateState(BuildContext context, Transfer transfer) {
    Provider.of<Transfers>(context, listen: false).add(transfer);
    Provider.of<Balance>(context, listen: false).sub(transfer.value);
  }
}
