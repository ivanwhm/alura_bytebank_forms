import 'package:flutter/material.dart';

exibirAlert({BuildContext context, String titulo, String content}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
