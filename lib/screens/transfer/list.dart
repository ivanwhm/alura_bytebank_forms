import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transfer.dart';
import '../../models/transfers.dart';

const _appBarTitle = 'Transfers';
const _labelValue = 'Value:';
const _labelTargetAccount = 'Target account:';

class TransfersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Consumer<Transfers>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.transfers.length,
            itemBuilder: (context, index) {
              Transfer transfer = value.transfers[index];
              return TransferItem(transfer);
            },
          );
        },
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer transfer;

  TransferItem(this.transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text('$_labelValue ${transfer.toStringValue()}'),
        subtitle: Text('$_labelTargetAccount ${transfer.toStringTargetAccount()}'),
      ),
    );
  }
}
