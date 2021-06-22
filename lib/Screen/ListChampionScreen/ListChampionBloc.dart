import 'dart:async';
import 'dart:convert';
import 'package:disposebag/disposebag.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:wallpaper/Base/BaseProvider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallpaper/Config/Result.dart';
import 'package:wallpaper/Model/Champion.dart';
import 'package:wallpaper/Network/Service/ChampionService.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionState.dart';
// ignore_for_file: close_sinks
typedef FunctionType<T> = T Function();
class ListChampionBloc {
  //Initial
  final ChampionRepo service = ChampionRepo();
  ListChampionMessage initialState = ListChampionSuccessMessage([]);

  //Input
  final PublishSubject<ListChampionAction> action = PublishSubject<ListChampionAction>();

  //Output
  final BehaviorSubject<bool> isLoading = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<ListChampionMessage> listChampion = BehaviorSubject<ListChampionMessage>();


  ListChampionBloc() {
    //Init current state
    listChampion.add(initialState);

    //Listen stream
    action.listen((ListChampionAction event) {

      if (event is GetListChampion) {
        listChampion.add(initialState);
        var data = service.listChampion()
            .doOnListen(() => {
              isLoading.add(true)
             })
            .doOnData((_) => isLoading.add(false))
            .map(_responseToMessage);
        listChampion.addStream(data);
      }
    });
  }

  static ListChampionMessage _responseToMessage(Result result) {
    if (result is SuccessState) {
      List<Champion> champions = [];
      var jsonData = json.decode(result.value);
      var name = jsonData['data'] as Map;
      // var name = data['data'] as Map;
      name.forEach((k,v){  // add .data here
        Champion champion = Champion.fromJson(v);
        champions.add(champion);
      });
      return ListChampionSuccessMessage(champions);
    } else  {
      var error = result as ErrorState;
      return ListChampionErrorMessage(error.msg);
    }
  }
}