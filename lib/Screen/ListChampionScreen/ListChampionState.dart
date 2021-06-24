

import 'package:flutter/cupertino.dart';
import 'package:wallpaper/Model/Champion.dart';
@immutable
abstract class ListChampionAction {}

class GetListChampion extends ListChampionAction {
  GetListChampion();
}

@immutable
abstract class ListChampionMessage {}

class ListChampionSuccessMessage extends ListChampionMessage {
  final List<Champion> listChampion;
  ListChampionSuccessMessage(this.listChampion);
}

class ListChampionErrorMessage extends ListChampionMessage {
  final String message;
  ListChampionErrorMessage(this.message);
}
