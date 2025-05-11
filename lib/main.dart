import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:teto/music_room.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MusicRoom game = MusicRoom();

  runApp(
    Container(
      color: Colors.black, // for letterbox bars
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 16,
          child: GameWidget(game: game),
        ),
      ),
    ),
  );
}

