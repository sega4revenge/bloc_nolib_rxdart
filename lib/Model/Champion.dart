import 'package:wallpaper/Network/TypeDecodable.dart';
import 'package:wallpaper/model/Skin.dart';
class Champion implements Decodable<Champion> {
  var id;
  var key;
  var name;
  var title;
  List<Skin>? skins ;

  Champion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        name = json['name'],
        title = json['title'],
        skins = (json['skins'] == null) ? null : (json['skins'] as List).map((i) => Skin.fromJson(i)).toList();


  Champion(this.id, this.key, this.name,this.title,this.skins);

  Map<String, dynamic> toJson() =>
      {'id': id, 'key': key, 'name': name,'title': title,'skins': skins};

  @override
  Champion decode(dynamic data) {
    id = data['id'] ;
    name = data['name'] ;
    key = data['key'];
    title = data['title'];
    skins = (data['skins'] == null) ? null : (data['skins'] as List).map((i) => Skin.fromJson(i)).toList();
    return this;
  }
}