class Character {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;
  String origin;
  String location;

  Character.fromMap(Map<String,dynamic> characterMap):
      id = characterMap["id"] ?? 0,
      name = characterMap["name"] ?? "",
      status = characterMap["status"] ?? "",
      species = characterMap["species"] ?? "",
      gender = characterMap["gender"] ?? "",
      image = characterMap["image"] ?? "",
      origin = characterMap["origin"]?["name"] ?? "",
      location = characterMap["location"]?["name"] ?? "";
}