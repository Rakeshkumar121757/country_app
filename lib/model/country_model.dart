

class CountryBaseModel {
  CountryBaseModel({
    required this.data,
  });

  Data data;

  factory CountryBaseModel.fromJson(Map<String, dynamic> json) => CountryBaseModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.countries,
  });

  List<CountryElement> countries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countries: List<CountryElement>.from(json["countries"].map((x) => CountryElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
  };
}

class CountryElement {
  CountryElement({
    required this.name,
    required this.languages,
  });

  String name;
  List<Language> languages;

  factory CountryElement.fromJson(Map<String, dynamic> json) => CountryElement(
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
