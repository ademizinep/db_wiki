import 'character_model.dart';
import 'sub_models.dart';

class CharactersList {
  List<Character> characters;
  Meta meta;
  Links links;

  CharactersList({
    required this.characters,
    required this.meta,
    required this.links,
  });

  factory CharactersList.fromJson(Map<String, dynamic> json) => CharactersList(
        characters: List<Character>.from(json["items"].map((x) => Character.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        links: Links.fromJson(json["links"]),
      );
}
