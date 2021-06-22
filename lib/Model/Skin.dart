class Skin {
  var id;
  var num;
  var name;
  bool chromas;
  Skin(this.id, this.num, this.name,this.chromas);

  Skin.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        num = json['num'],
        name = json['name'],
        chromas = json['chromas'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'num': num, 'name': name,'chromas': chromas};
}