class CharacterModel {
  int id;
  String name;
  String ki;
  String maxKi;
  String race;
  String gender;
  String description;
  String image;
  String affiliation;
  String? deletedAt;

  CharacterModel({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    required this.deletedAt,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        ki: json["ki"],
        maxKi: json["maxKi"],
        race: json["race"],
        gender: json["gender"],
        description: json["description"],
        image: json["image"],
        affiliation: json["affiliation"],
        deletedAt: json["deletedAt"],
      );
}
