
import 'package:wallpaper/Config/Result.dart';

import 'ChampionService.dart';

class ChampionRepo {
  ChampionService service = ChampionService();

  Stream<Result> listChampion() {
    return Stream.fromFuture(service.listChampion());
  }

  Stream<Result> detailChampion(String id) {
    return Stream.fromFuture(service.detailChampion(championId: id));
  }
}
