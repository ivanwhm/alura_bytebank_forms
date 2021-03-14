import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

import '../../components/mensagem.dart';
import '../dashboard/dashboard.dart';
import 'register.dart';

class Login extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/bytebank_logo.png',
                  width: 200.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300.0,
                  height: 455.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _construirFormulario(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget _construirFormulario(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Text(
            'Faça Seu Login',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
              hintText: '000.000.000-00',
            ),
            maxLength: 14,
            keyboardType: TextInputType.number,
            controller: _cpfController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) => Validator.cpf(value) ? "CPF Inválido." : null,
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            maxLength: 15,
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value.length == 0) {
                return 'Informe a senha.';
              }

              return null;
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: double.infinity,
            // ignore: deprecated_member_use
            child: OutlineButton(
              child: const Text('CONTINUAR'),
              textColor: Theme.of(context).accentColor,
              highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                if (_formkey.currentState.validate()) {
                  if (_cpfController.text == '026.327.839-50' && _passwordController.text == "12345678") {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Dashboard()), (_) => false);
                  } else {
                    exibirAlert(context: context, titulo: "Erro", content: "CPF ou Senha inválidos.");
                  }
                }
              },
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          // ignore: deprecated_member_use
          OutlineButton(
            child: Text(
              'Criar uma conta',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            textColor: Theme.of(context).accentColor,
            highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              final route = MaterialPageRoute(builder: (context) => Register());
              Navigator.of(context).push(route);
            },
          ),
        ],
      ),
    );
  }
}
