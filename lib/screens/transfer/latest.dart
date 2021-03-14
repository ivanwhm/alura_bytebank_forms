import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transfers.dart';
import 'list.dart';

const _latestTransferTitle = 'Latest Transfers';
const _labelShowTransfersButton = 'View All';
const _hasNoTransferError = 'Has no Transfers to Show.';

class LatestTransfers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        Text(
          _latestTransferTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        Consumer<Transfers>(
          builder: (context, value, child) {
            final _latestTransfers = value.transfers.reversed.toList();
            final _count = _latestTransfers.length <= 2 ? _latestTransfers.length : 2;

            return _count > 0
                ? ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: _count,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TransferItem(_latestTransfers[index]);
                    },
                  )
                : HasNoTransfers();
          },
        ),
        ElevatedButton(
          child: Text(_labelShowTransfersButton),
          onPressed: () => _viewTransfers(context),
        ),
      ],
    );
  }

  void _viewTransfers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransfersList()),
    );
  }
}

class HasNoTransfers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          _hasNoTransferError,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
