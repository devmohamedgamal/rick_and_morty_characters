// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharacterModel {
  late dynamic id;
  late String status;
  late String species;
  late String type;
  late String gander;
  late String name;
  late String image;
  late CharacterLocation origin;
  late CharacterLocation location;

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    status = json["status"];
    species = json["species"];
    type = json["type"];
    gander = json["gender"];
    origin = CharacterLocation.fromJson(json["origin"]);
    location = CharacterLocation.fromJson(json["location"]);
    name = json["name"];
    image = json["image"];
  }
}

class CharacterLocation {
  CharacterLocation({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
