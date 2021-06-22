import 'dart:convert';

import 'package:wallpaper/Network/TypeDecodable.dart';

// class Crypto {
//   final String name;
//   final String symbol;
//   final String rank;
//
//   Crypto({required this.name, required this.symbol, required this.rank});
//
//   factory Crypto.fromJson(Map<String, dynamic> json) =>
//       Crypto(
//           name: json["name"],
//           symbol: json["symbol"],
//           rank: json["cmc_rank"]);
//
//   static List<Crypto> fromJsonList(String list) {
//     List<Crypto> listCrypto = (list as List).map((tagJson) => Crypto.fromJson(tagJson)).toList();
//     return listCrypto;
//   }
//
//   Map<String, dynamic> toJson() =>
//       {"name": name, "symbol": symbol, "cmc_rank": rank};
// }



class Crypto implements Decodable<Crypto> {
  String name = '';
  String symbol = '';
  int rank = 0;

  @override
  Crypto decode(dynamic data) {
    name = data['name'] ?? '';
    symbol = data['symbol'] ?? '';
    rank = data['cmc_rank'] ?? 0;
    return this;
  }

}