import 'package:wallpaper/Network/TypeDecodable.dart';
import 'package:wallpaper/Model/Skin.dart';
class Champion implements Decodable<Champion> {
  String id = '';
  String key= '';
  String name= '';
  String title= '';
  List<Skin> skins = [];

  Champion();

  Champion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        name = json['name'],
        title = json['title'],
        skins = (json['skins'] as List).map((i) => Skin.fromJson(i)).toList();

  Map<String, dynamic> toJson() =>
      {'id': id, 'key': key, 'name': name,'title': title,'skins': skins};

  @override
  Champion decode(dynamic data) {
    id = data['id'] ;
    name = data['name'] ;
    key = data['key'];
    title = data['title'];
    var skinArray = data['skins'];
    if (skinArray != null) {
      skins = (skinArray as List).map((i) => Skin().decode(i)).toList();
    }
    return this;
  }
}