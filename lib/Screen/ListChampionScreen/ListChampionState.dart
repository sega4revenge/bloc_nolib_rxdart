

import 'package:flutter/cupertino.dart';
import 'package:wallpaper/Model/Champion.dart';
@immutable
abstract class ListChampionAction {}

class GetListChampion extends ListChampionAction {
  GetListChampion();
}

@immutable
abstract class ListChampionMessage {}

class ListChampionSuccessMessage implements ListChampionMessage {
  final List<Champion> listChampion;
  const ListChampionSuccessMessage(this.listChampion);
}

class ListChampionErrorMessage implements ListChampionMessage {

  final String message;

  const ListChampionErrorMessage(this.message);

  @override
  String toString() => 'ListChampionErrorMessage{message=$message}';
}
