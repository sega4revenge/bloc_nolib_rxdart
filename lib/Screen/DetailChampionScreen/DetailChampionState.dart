

import 'package:flutter/cupertino.dart';
import 'package:wallpaper/Model/Champion.dart';
import 'package:wallpaper/Model/Skin.dart';
@immutable
abstract class DetailChampionAction {}

class DetailChampionActionSelectSkin extends DetailChampionAction {
  final int index;
  DetailChampionActionSelectSkin(this.index);
}

class DetailChampionGetDetail extends DetailChampionAction {
  DetailChampionGetDetail();
}


@immutable
abstract class DetailChampionMessage {}

class DetailChampionDataMessage extends DetailChampionMessage {
  final Champion champion;
  DetailChampionDataMessage(this.champion);
}

class DetailChampionGetMessage extends DetailChampionDataMessage {
  DetailChampionGetMessage({required Champion champion}) : super(champion);
}

class DetailChampionSelectSkinMessage extends DetailChampionDataMessage {
  final Skin skin;
  DetailChampionSelectSkinMessage({required Champion champion, required this.skin}) : super(champion);
}

class DetailChampionInitialMessage extends DetailChampionMessage {
  DetailChampionInitialMessage();
}

class DetailChampionErrorMessage extends DetailChampionMessage {
  final String message;
  DetailChampionErrorMessage(this.message);
}