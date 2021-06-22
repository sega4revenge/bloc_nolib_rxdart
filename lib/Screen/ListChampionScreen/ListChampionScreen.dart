

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/Config/Result.dart';
import 'package:wallpaper/Model/Champion.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionBloc.dart';
import 'package:wallpaper/Screen/ListChampionScreen/ListChampionState.dart';


class ListChampionScreenPage extends StatefulWidget {
  ListChampionScreenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListChampionScreenState();
  }
}

class ListChampionScreenState extends State<ListChampionScreenPage> {
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
    return RxStreamBuilder<ListChampionMessage>(
      stream: bloc.listChampion,
      builder: (context, state) {
        if (state is ListChampionSuccessMessage) {
          var data = state.listChampion;
          print(data.length);
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
                    // Navigator.push(context,
                    //     CupertinoPageRoute(
                    //         fullscreenDialog: false,
                    //         builder: (context) => ChampionDetail.ChampionDetail(champion : asyncSnapshot.data[index])
                    //     ));
                  });
            },
          );
        } else {
          return Text("Error");
        }
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.bloc}) : super(key: key);

  final ListChampionBloc bloc;

  @override
  Widget build(BuildContext context) {
    return RxStreamBuilder<bool>(
      stream: bloc.isLoading,
      builder: (context, state) {
        if (state) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}