// To parse this JSON data, do
//
//     final cat = catFromJson(jsonString);

import 'dart:convert';

List<Cat> catFromJson(String str) =>
    List<Cat>.from(json.decode(str).map((x) => Cat.fromJson(x)));

String catToJson(List<Cat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cat {
  List<dynamic> breeds;
  String id;
  String url;
  int width;
  int height;

  Cat({
    this.breeds,
    this.id,
    this.url,
    this.width,
    this.height,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        breeds: List<dynamic>.from(json["breeds"].map((x) => x)),
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "breeds": List<dynamic>.from(breeds.map((x) => x)),
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
