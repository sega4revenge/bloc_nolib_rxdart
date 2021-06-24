

import 'package:dio/dio.dart';
import 'package:wallpaper/Config/Result.dart';


import '../APIClient.dart';

import '../APIRouteConfigurable.dart';
import 'ChampionTarget.dart';

class ChampionRouter implements APIRouteConfigurable {

  final ChampionTarget target;

  ChampionRouter(this.target);

  @override
  RequestOptions getConfig() {
    switch (target.runtimeType) {
      case ListChampionTarget:
        return RequestOptions(
            path: 'champion.json',
            method: APIMethod.get,
            queryParameters: target.routeParams()
        );
      case DetailChampionTarget:
        var request = target as DetailChampionTarget;
        return RequestOptions(
            path: 'champion/${request.championId}.json',
            method: APIMethod.get,
            queryParameters: target.routeParams()
        );

      default:
        return RequestOptions(
            path: '',
        );
    }
  }
}

class ChampionService {
  final APIClient client = APIClient();

  Future<Result> listChampion() async {
    ChampionRouter router = ChampionRouter(ListChampionTarget());
    var result = await client.request(
        route: router
    );
    return result;
  }

  Future<Result> detailChampion({required String championId}) async {
    ChampionRouter router = ChampionRouter(DetailChampionTarget(championId));
    var result = await client.request(
        route: router
    );
    return result;
  }
}