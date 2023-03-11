import 'dart:convert';

Details detailsFromJson(String str) {
  final jsonData = json.decode(str);
  return Details.fromMap(jsonData);
}

class Details{

  final int id;
  final String name;
  final String address;

  const Details({required this.id, required this.name, required this.address});

  Map<String, dynamic> toMap() => {

    "id": id,
    "name": name,
    "address": address,

  };

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    address: json["address"],
  );
}
