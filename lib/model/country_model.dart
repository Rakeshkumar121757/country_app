import 'package:countries/model/language_model.dart';

class CountryBaseModel {
  CountryBaseModel({
    required this.country_item,
  });
  CountryItem country_item;
  factory CountryBaseModel.fromJson(Map<String, dynamic> js) =>
      CountryBaseModel(
        country_item: CountryItem.fromJson(js["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": country_item.toJson(),
      };
}

class CountryItem {
  CountryItem({
    required this.countries,
  });
  List<CountryRemoteModel> countries;
  factory CountryItem.fromJson(Map<String, dynamic> js) => CountryItem(
        countries: List<CountryRemoteModel>.from(
            js["countries"].map((x) => CountryRemoteModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class CountryRemoteModel {
  CountryRemoteModel({
    required this.name,
    required this.languages,
  });
  String name;
  List<Language> languages;
  factory CountryRemoteModel.fromJson(Map<String, dynamic> js) =>
      CountryRemoteModel(
        name: js["name"],
        languages: List<Language>.from(
            js["languages"].map((x) => Language.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
      };
}
