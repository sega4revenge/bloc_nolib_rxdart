

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/Base/BaseLoadingWidget.dart';
import 'package:wallpaper/Model/Champion.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionRoute.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionBloc.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionState.dart';

class ListChampionScreenPage extends StatefulWidget {
  ListChampionScreenPage({Key? key}) : super(key: key);

  @override
  ListChampionScreenState createState() {
    return ListChampionScreenState();
  }
}

class ListChampionScreenState extends State<ListChampionScreenPage> {
  @override
  void didChangeDependencies() {
    final bloc = Provider.of<ListChampionBloc>(context);
    bloc.action.add(GetListChampion());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ListChampionBloc>(context);

    return Scaffold(
        backgroundColor: CupertinoColors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                      ListChampionWidget(bloc: bloc)
                    ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child:
                    LoadingWidget(bloc: bloc)
                ),
              )

            ],
          )

         ,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            setState(() {
              bloc.action.add(GetListChampion());
            });
          },
          tooltip: 'Increment',
        ));
  }


}

class ListChampionWidget extends StatelessWidget {
  const ListChampionWidget({Key? key, required this.bloc}) : super(key: key);

  final ListChampionBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListChampionMessage>(
      stream: bloc.response,
      builder: (context, stateData) {
        var state = stateData.data;
        if (state is ListChampionSuccessMessage) {
          var data = state.listChampion;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              Champion champion = data[index];
              return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "http://ddragon.leagueoflegends.com/cdn/11.11.1/img/champion/" +
                              champion.id + ".png")),
                  title: Text(champion.name),
                  subtitle: Text(champion.title),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailChampionRoute.routeId,
                      arguments: DetailChampionRoute(champion.id),
                    );
                  });
            },
          );
        } else {
          print(state);
          return Text("Error");
        }
      },
    );
  }
}