import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/Config/SharedPreferences.dart';
import 'package:wallpaper/Network/Service/ChampionRepo.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionBloc.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionRoute.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionScreen.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionBloc.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionRoute.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionScreen.dart';

void main() async {

  runApp(MyApp());
  spUtil = await SpUtil.getInstance();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChampionRepo repo = ChampionRepo();

    return MaterialApp(
      title: 'League of Legends Wallpaper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ListChampionRoute.routeId,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ListChampionRoute.routeId:
            return MaterialPageRoute(builder: (context) {
              return Provider<ListChampionBloc>(
                create: (context) => ListChampionBloc(repo),
                dispose: (_, bloc) => bloc.dispose(),
                child: ListChampionScreenPage(),
              );
            },);
          case DetailChampionRoute.routeId:
            var arguments = settings.arguments as DetailChampionRoute;
            return MaterialPageRoute(builder: (context) {
              return Provider<DetailChampionBloc>(
                create: (context) => DetailChampionBloc(championId: arguments.championId, repo: repo),
                dispose: (_, bloc) => bloc.dispose(),
                child: DetailChampionScreen(),
              );
            },);
        }
      },
    );
  }
}

SpUtil? spUtil;

init() async {
  spUtil = await SpUtil.getInstance();
}
