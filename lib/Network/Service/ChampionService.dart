
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallpaper/Config/ConfigBase.dart';
import 'package:wallpaper/Config/Result.dart';
import 'package:wallpaper/Model/Champion.dart';

import '../APIClient.dart';
import '../APIResponse.dart';
import '../APIRouteConfigurable.dart';

enum ChampionRequest {
  listChampion
}

class ChampionRouter implements APIRouteConfigurable {

  final ChampionRequest request;
  final Map<String, dynamic>? routeParams;

  ChampionRouter(this.request, { this.routeParams });

  @override
  RequestOptions getConfig() {
    switch (request) {
      case ChampionRequest.listChampion:
        return RequestOptions(
            path: 'champion.json',
            method: APIMethod.get,
            queryParameters: routeParams
        );
    }
  }
}

class ChampionService {
  //Creating Singleton

  final APIClient client = APIClient();

  Future<Result> listChampion() async {
    ChampionRouter router = ChampionRouter(ChampionRequest.listChampion);
    var result = await client.request(
        route: router
    );
    List<Champion> champions = [];
    if (result is SuccessState) {

      var jsonData = json.decode(result.value);
      var name = jsonData['data'] as Map;
      // var name = data['data'] as Map;
      name.forEach((k,v){  // add .data here
        Champion champion = Champion.fromJson(v);
        champions.add(champion);
      });
    }
    return result;
  }
}

class ChampionRepo {
  ChampionService service = ChampionService();



  Stream<Result> listChampion() {
    return Stream.fromFuture(service.listChampion());
  }
}
