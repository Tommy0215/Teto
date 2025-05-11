import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:teto/music_room.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();


  MusicRoom game = MusicRoom();

  runApp(
    Container(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.5,
          child: GameWidget(game: game),
        ),
      ),
    ),
  );
}

