import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:wallpaper/Base/BaseBloc.dart';
import 'package:wallpaper/Config/Result.dart';
import 'package:wallpaper/Model/Champion.dart';
import 'package:wallpaper/Network/Service/ChampionRepo.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionState.dart';

typedef FunctionType<T> = T Function();
class ListChampionBloc extends BaseBloc {
  //Initial
  ListChampionMessage initialState = ListChampionSuccessMessage([]);

  //Input
  final PublishSubject<ListChampionAction> action = PublishSubject<ListChampionAction>();
  final BehaviorSubject<ListChampionMessage> response = BehaviorSubject<ListChampionMessage>();


  ListChampionBloc(ChampionRepo repo) {
    //Init current state
    response.add(initialState);

    //Listen stream
    action.listen((ListChampionAction event) {
      if (event is GetListChampion) {
        print("get data");
        response.add(initialState);
        var data = repo.listChampion()
            .doOnListen(() => {
              isLoading.add(true)
             })
            .doOnData((_) => isLoading.add(false))
            .map(_responseToMessage);
        response.addStream(data);
      }
    });
  }

  ListChampionMessage _responseToMessage(Result result) {
    if (result is SuccessState) {
      List<Champion> champions = [];
      var jsonData = json.decode(result.value);
      var name = jsonData['data'] as Map;
      // var name = data['data'] as Map;
      name.forEach((k,v){  // add .data here
        Champion champion = Champion().decode(v);
        champions.add(champion);
      });
      return ListChampionSuccessMessage(champions);
    } else  {
      var error = result as ErrorState;
      return ListChampionErrorMessage(error.msg);
    }
  }
  @override
  void dispose() {
    super.dispose();
    response.close();
    action.close();
  }
}