import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/Config/SharedPreferences.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionBloc.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionScreen.dart';

void main() async {

  runApp(MyApp());
  spUtil = await SpUtil.getInstance();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League of Legends Wallpaper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) {
              return Provider<ListChampionBloc>(
                create: (context) => ListChampionBloc(),
                child: ListChampionScreenPage(),
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
