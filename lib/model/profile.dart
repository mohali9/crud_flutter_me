import 'dart:convert';

class Profile {
  int id;
  String title;
  String description;
  String file;
  String image;

  Profile({this.id = 0, this.title, this.description, this.file, this.image});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        file: map["file"],
        image: map["image"],);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "file": file,
      "image": image,
    };
  }

  @override
  String toString() {
    return 'Profile{id: $id, title: $title, description: $description, file: $file, image: $image}';
  }
}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
