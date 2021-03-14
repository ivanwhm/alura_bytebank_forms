import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../components/biometric.dart';
import '../../models/customer.dart';
import '../dashboard/dashboard.dart';

class Register extends StatelessWidget {
  // Step 1
  final _formUserData = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _mobilePhoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  // Step 2
  final _formUserAddress = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _regionController = TextEditingController();
  final _cityController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();
  // Step 3
  final _formUserAuth = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _rgPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Consumer<Customer>(
        builder: (context, customer, child) {
          return Stepper(
            currentStep: customer.currentStep,
            onStepContinue: () {
              final functions = [
                _saveStep1,
                _saveStep2,
                _saveStep3,
              ];
              return functions[customer.currentStep](context);
            },
            onStepCancel: () {
              customer.currentStep = customer.currentStep > 0 ? customer.currentStep - 1 : 0;
            },
            type: StepperType.vertical,
            steps: _buildSteps(context, customer),
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: onStepContinue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                    ),
                    TextButton(
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: onStepCancel,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Step> _buildSteps(BuildContext context, Customer customer) {
    return [
      Step(
        title: Text('Seus dados'),
        isActive: customer.currentStep >= 0,
        content: Form(
          key: _formUserData,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'John Appleseed',
                ),
                keyboardType: TextInputType.name,
                maxLength: 255,
                validator: (value) {
                  if (value.length < 3) {
                    return 'Nome inválido.';
                  }

                  if (!value.contains(" ")) {
                    return 'Informe pelo menos um sobrenome.';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'john.appleseed@apple.com',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                maxLength: 255,
                validator: (value) => Validator.email(value) ? 'E-mail inválido' : null,
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  hintText: '000.000.000-00',
                ),
                keyboardType: TextInputType.number,
                maxLength: 14,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: (value) => Validator.cpf(value) ? 'CPF inválido.' : null,
              ),
              TextFormField(
                controller: _mobilePhoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  hintText: '(00) 00000-0000',
                ),
                keyboardType: TextInputType.number,
                maxLength: 15,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                validator: (value) => Validator.phone(value) ? 'Telefone inválido.' : null,
              ),
              DateTimePicker(
                controller: _birthDateController,
                type: DateTimePickerType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Data de nascimento',
                dateMask: 'dd/MM/yyyy',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Data inválida.';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text("Endereço"),
        isActive: customer.currentStep >= 1,
        content: Form(
          key: _formUserAddress,
          child: Column(
            children: [
              TextFormField(
                controller: _cepController,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  hintText: '00000-000',
                ),
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(ponto: false),
                ],
                validator: (value) => Validator.cep(value) ? "CEP inválido." : null,
              ),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Estado',
                ),
                items: Estados.listaEstadosSigla.map((estado) {
                  return DropdownMenuItem(
                    child: Text(estado),
                    value: estado,
                  );
                }).toList(),
                onChanged: (selectedRegion) => _regionController.text = selectedRegion,
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um estado.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Cidade',
                  hintText: 'Blumenau',
                ),
                keyboardType: TextInputType.text,
                maxLength: 255,
                validator: (value) {
                  if (value.length < 3) {
                    return 'Cidade inválida.';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _neighborhoodController,
                decoration: InputDecoration(
                  labelText: 'Bairro',
                  hintText: 'Centro',
                ),
                keyboardType: TextInputType.text,
                maxLength: 255,
                validator: (value) {
                  if (value.length < 3) {
                    return 'Bairro inválido.';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Logradouro',
                  hintText: 'Rua 7 de Setembro',
                ),
                keyboardType: TextInputType.text,
                maxLength: 255,
                validator: (value) {
                  if (value.length < 3) {
                    return 'Logradouro inválida.';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Número',
                  hintText: '123',
                ),
                keyboardType: TextInputType.text,
                maxLength: 15,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Número inválido.';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Autenticação'),
        isActive: customer.currentStep >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                keyboardType: TextInputType.text,
                maxLength: 255,
                obscureText: true,
                validator: (value) {
                  if (value.length < 8) {
                    return 'Senha muito curta.';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _passwordConfirmationController,
                decoration: InputDecoration(
                  labelText: 'Confirmar a senha',
                ),
                keyboardType: TextInputType.text,
                maxLength: 255,
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Senhas informadas são diferentes.';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Para prosseguir com o seu cadastro é necessário que tenhamos uma foto do seu RG.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                child: const Text('Tirar foto do meu RG'),
                onPressed: () {
                  _captureRg(customer);
                },
              ),
              _alreadySendRg(context) ? _rgImage(context) : _rgRequest(context),
              Bioemetric(),
            ],
          ),
        ),
      ),
    ];
  }

  void _saveStep1(BuildContext context) {
    if (_formUserData.currentState.validate()) {
      final customer = Provider.of<Customer>(context, listen: false);
      customer.name = _nameController.text;
      customer.email = _emailController.text;
      customer.cpf = _cpfController.text;
      customer.phone = _mobilePhoneController.text;
      customer.birthDate = _birthDateController.text;
      _nextStep(context);
    }
  }

  void _saveStep2(BuildContext context) {
    if (_formUserAddress.currentState.validate()) {
      final customer = Provider.of<Customer>(context, listen: false);
      customer.cep = _cepController.text;
      customer.region = _regionController.text;
      customer.city = _cityController.text;
      customer.neighboorhood = _neighborhoodController.text;
      customer.address = _addressController.text;
      customer.number = _numberController.text;
      _nextStep(context);
    }
  }

  void _saveStep3(BuildContext context) {
    final customer = Provider.of<Customer>(context, listen: false);
    if (_formUserAuth.currentState.validate() && customer.rgImage != null) {
      customer.password = _passwordController.text;
      customer.rgImage = null;

      FocusScope.of(context).unfocus();

      final route = MaterialPageRoute(builder: (context) => Dashboard());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);

      customer.currentStep = 0;
    }
  }

  void _nextStep(BuildContext context) {
    Customer customer = Provider.of<Customer>(context, listen: false);
    _goTo(customer.currentStep + 1, customer);
  }

  void _goTo(int currentStep, Customer customer) {
    customer.currentStep = currentStep;
  }

  void _captureRg(Customer customer) async {
    final pickedImage = await _rgPicker.getImage(
      source: ImageSource.camera,
    );
    customer.rgImage = File(pickedImage.path);
  }

  bool _alreadySendRg(BuildContext context) {
    return Provider.of<Customer>(context).rgImage != null;
  }

  Image _rgImage(BuildContext context) {
    return Image.file(Provider.of<Customer>(context).rgImage);
  }

  Column _rgRequest(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Foto do RG pendente.',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
