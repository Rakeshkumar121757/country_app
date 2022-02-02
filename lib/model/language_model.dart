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