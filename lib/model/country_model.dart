

class CountryBaseModel {
  CountryBaseModel({
    required this.country_item,
  });
  CountryItem country_item;
  factory CountryBaseModel.fromJson(Map<String, dynamic> json) => CountryBaseModel(
    country_item: CountryItem.fromJson(json["data"]),
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

  factory CountryItem.fromJson(Map<String, dynamic> json) => CountryItem(
    countries: List<CountryRemoteModel>.from(json["countries"].map((x) => CountryRemoteModel.fromJson(x))),
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

  factory CountryRemoteModel.fromJson(Map<String, dynamic> json) => CountryRemoteModel(
    name: json["name"],
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
  };
}

class Language {
  Language({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}
