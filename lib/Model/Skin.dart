import 'package:wallpaper/Network/TypeDecodable.dart';


class Skin implements Decodable<Skin>  {
  String? id;
  int? num;
  String? name;
  bool? chromas;

  Skin();

  @override
  Skin decode(data) {
    id = data['id'] ?? '';
    num = data['num'] ?? 0;
    name = data['name'] ?? '';
    chromas = data['chromas'] ?? false;
    return this;
  }

  Skin.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        num = json['num'],
        name = json['name'],
        chromas = json['chromas'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'num': num, 'name': name,'chromas': chromas};
}