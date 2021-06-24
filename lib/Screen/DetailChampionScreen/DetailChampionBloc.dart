import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:wallpaper/Base/BaseBloc.dart';
import 'package:wallpaper/Config/Result.dart';
import 'package:wallpaper/Model/Champion.dart';

import 'package:wallpaper/Network/Service/ChampionRepo.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionState.dart';


class DetailChampionBloc extends BaseBloc  {
  DetailChampionMessage initialState = DetailChampionInitialMessage();
  Champion? champion;

  //Input
  final PublishSubject<DetailChampionAction> action =
      PublishSubject<DetailChampionAction>();

  //Output
  final BehaviorSubject<DetailChampionMessage> responseBloc =
      BehaviorSubject<DetailChampionMessage>();

  DetailChampionBloc({required String championId, required ChampionRepo repo}) {
    //Init current state
    responseBloc.add(initialState);
    //Listen stream
    action.listen((DetailChampionAction event) {
      switch (event.runtimeType) {
        case DetailChampionGetDetail:
          var data = repo
              .detailChampion(championId)
              .doOnListen(() => {
                isLoading.add(true)
              })
              .doOnData((_) => isLoading.add(false))
              .map((result) =>
                _responseToMessage(result, championId)
              );
          responseBloc.addStream(data);
          break;
        case DetailChampionActionSelectSkin:
          var index = (event as DetailChampionActionSelectSkin).index;
          var champion = this.champion;
          var skinSelected = champion?.skins[index];
          if (skinSelected != null && champion != null) {
            responseBloc.add(DetailChampionSelectSkinMessage(champion: champion, skin: skinSelected));
          }
          break;
      }
    });
  }

  DetailChampionMessage _responseToMessage(Result result, String championId) {

    if (result is SuccessState) {
      var jsonData = json.decode(result.value);
      var data = jsonData['data'] as Map;
      var championLocal = Champion().decode(data["$championId"]);
      this.champion = championLocal;
      return DetailChampionGetMessage(champion: championLocal);
    } else {
      var error = result as ErrorState;
      return DetailChampionErrorMessage(error.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
    responseBloc.close();
    action.close();
  }
}
