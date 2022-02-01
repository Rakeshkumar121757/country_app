import 'dart:convert';

import 'package:countries/model/country.dart';
import 'package:countries/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CountryProvider extends ChangeNotifier {
  Api _api = Api();
  List<CountryElement> _countries = [];
  List<Language> _languages = [];
  CountryElement _country;

  List<CountryElement> get countries => _countries;
  List<Language> get languages => _languages;

  CountryElement get country => _country;

  Future refreshScreen() async {
    notifyListeners();
  }

  Future getCountryName() async {
    final result = await _api.getCountry();
    final decode = jsonDecode(result);
    final parse = Data.fromJson(decode);
    _countries = parse.countries;
    _countries.sort((a, b) => a.name.compareTo(b.name));

    notifyListeners();
  }

  Future getLanguages() async {
    final result = await _api.getLanguages();
    final decode = jsonDecode(result);
    for(var l in decode) {
      languages.add(Language.fromJson(l));
    }

    notifyListeners();
  }

  Future getCountryNameByCode(context, {String code}) async {
    final result = await _api.getCountryByCode(context, code: code);
    if (result != null) {
      final decode = jsonDecode(result);
      if (decode['country'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Country Code doesn't exists"),
          backgroundColor: Colors.red,
        ));
        return;
      }
      final parse = CountryElement.fromJson(decode['country']);
      _country = parse;

      notifyListeners();
      return parse.name;
    }
  }
}
