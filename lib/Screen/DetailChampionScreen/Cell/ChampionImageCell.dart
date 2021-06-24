import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wallpaper/Model/Skin.dart';

class ChampionImageCell extends StatefulWidget {
  ChampionImageCell({Key? key, required this.skin,required this.championName}) : super(key: key);
  final Skin skin;
  final String championName;

  @override
  ChampionImageCellState createState() => ChampionImageCellState();
}


class ChampionImageCellState extends State<ChampionImageCell> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${widget.championName}_${widget.skin.num}.jpg")
            )
        ),
      ),
    );
  }
}
