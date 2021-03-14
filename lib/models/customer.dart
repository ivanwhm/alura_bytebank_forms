import 'dart:io';

import 'package:flutter/material.dart';

class Customer extends ChangeNotifier {
  String _name;
  String _email;
  String _password;
  String _cpf;
  String _phone;
  String _birthDate;
  String _cep;
  String _region;
  String _city;
  String _neighboorhood;
  String _address;
  String _number;
  int _currentStep = 0;
  File _rgImage;
  bool _biometric;

  get name => this._name;
  get email => this._email;
  get password => this._password;
  get cpf => this._cpf;
  get phone => this._phone;
  get birthDate => this._birthDate;
  get cep => this._cep;
  get region => this._region;
  get city => this._city;
  get neighboorhood => this._neighboorhood;
  get address => this._address;
  get number => this._number;
  get currentStep => this._currentStep;
  get rgImage => this._rgImage;
  get biometric => this._biometric;

  set name(String value) {
    this._name = value;
    this.notifyListeners();
  }

  set email(value) {
    this._email = value;
    this.notifyListeners();
  }

  set password(value) {
    this._password = value;
    this.notifyListeners();
  }

  set cpf(value) {
    this._cpf = value;
    this.notifyListeners();
  }

  set phone(value) {
    this._phone = value;
    this.notifyListeners();
  }

  set birthDate(value) {
    this._birthDate = value;
    this.notifyListeners();
  }

  set cep(value) {
    this._cep = value;
    this.notifyListeners();
  }

  set region(value) {
    this._region = value;
    this.notifyListeners();
  }

  set city(value) {
    this._city = value;
    this.notifyListeners();
  }

  set neighboorhood(value) {
    this._neighboorhood = value;
    this.notifyListeners();
  }

  set address(value) {
    this._address = value;
    this.notifyListeners();
  }

  set number(value) {
    this._number = value;
    this.notifyListeners();
  }

  set currentStep(int value) {
    this._currentStep = value;
    this.notifyListeners();
  }

  set rgImage(File rgImage) {
    this._rgImage = rgImage;
    this.notifyListeners();
  }

  set biometric(bool biometric) {
    this._biometric = biometric;
    this.notifyListeners();
  }
}
