class Language {
  Language({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Language.fromJson(Map<String, dynamic> js) => Language(
    code: js["code"],
    name: js["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}