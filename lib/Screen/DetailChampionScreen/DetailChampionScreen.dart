import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/Base/BaseLoadingWidget.dart';
import 'package:wallpaper/Model/Champion.dart';
import 'package:wallpaper/Model/Skin.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionBloc.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/Screen/DetailChampionScreen/DetailChampionState.dart';

import 'Cell/ChampionImageCell.dart';

class DetailChampionScreen extends StatefulWidget {
  DetailChampionScreen({Key? key}) : super(key: key);

  @override
  DetailChampionScreenState createState() => DetailChampionScreenState();
}

class DetailChampionScreenState extends State<DetailChampionScreen> {
  @override
  void didChangeDependencies() {
    final bloc = Provider.of<DetailChampionBloc>(context);
    bloc.action.add(DetailChampionGetDetail());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DetailChampionBloc>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: StreamBuilder<DetailChampionMessage>(
            stream: bloc.responseBloc,
            builder: (context, stateData) {
              var state = stateData.data;
              if (state is DetailChampionDataMessage) {
                return Text(state.champion.name);
              } else {
                return Text("Error");
              }
            }),
      ),
      body: Container(
        child: Stack(
          children: [
            ContainerDetailChampion(bloc: bloc),
            Center(
              child: LoadingWidget(bloc: bloc),
            )
          ],
        ),
      ),
    );
  }

  containerView(DetailChampionBloc bloc) {}

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}

class ContainerDetailChampion extends StatelessWidget {
  const ContainerDetailChampion({Key? key, required this.bloc})
      : super(key: key);

  final DetailChampionBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DetailChampionMessage>(
        stream: bloc.responseBloc,
        builder: (context, stateData) {
          var state = stateData.data;
          if (state is DetailChampionGetMessage) {
            var champion = state.champion;
            return GridWallpaper(
                skins: champion.skins, champion: champion, bloc: bloc);
          } else if (state is DetailChampionSelectSkinMessage) {
            var champion = state.champion;
            var skinSelected =
                (stateData.data as DetailChampionSelectSkinMessage).skin;
            return Column(
              children: <Widget>[
                SelectedWallpaper(skin: skinSelected, champion: champion),
                Expanded(
                    child: GridWallpaper(
                        skins: champion.skins, champion: champion, bloc: bloc))
              ],
            );
          } else if (state is DetailChampionErrorMessage) {
            return Center(child: Text("Error"));
          } else {
            return Container();
          }
        });
  }
}

class SelectedWallpaper extends StatelessWidget {
  const SelectedWallpaper(
      {Key? key, required this.skin, required this.champion})
      : super(key: key);

  final Skin skin;
  final Champion champion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        print("oke");
      },
      // The custom button
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${champion.name}_${skin.num}.jpg"))),
        ),
      ),
    );
  }
}

class GridWallpaper extends StatelessWidget {
  const GridWallpaper(
      {Key? key,
      required this.skins,
      required this.champion,
      required this.bloc})
      : super(key: key);

  final List<Skin> skins;
  final Champion champion;
  final DetailChampionBloc bloc;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: width / (width * 0.6),
        ),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: skins.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: ChampionImageCell(
                  skin: skins[index], championName: champion.id),
              onTap: () {
                bloc.action.add(DetailChampionActionSelectSkin(index));
              });
        });
  }
}
