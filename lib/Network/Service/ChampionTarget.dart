

import 'package:flutter/cupertino.dart';

@immutable
abstract class ChampionTarget {
  Map<String, dynamic>? routeParams();
}

class ListChampionTarget implements ChampionTarget {
  ListChampionTarget();

  @override
  Map<String, dynamic>? routeParams() {
    return null;
  }
}

class DetailChampionTarget extends ChampionTarget {
  final String championId;
  DetailChampionTarget(this.championId);

  @override
  Map<String, dynamic>? routeParams() {
    return null;
  }
}
