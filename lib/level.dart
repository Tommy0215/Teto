import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:teto/music_room.dart';
import 'package:teto/player.dart';

class Level extends World with HasGameReference<MusicRoom>{
  late Background horrorBackground;

  final playerSize = Vector2.all(128);

  @override
  FutureOr<void> onLoad() {

    horrorBackground = Background(size: game.size, path: 'horror.jpeg');
    add(horrorBackground);
    add(Player(position: Vector2(200, game.size.y/1.1 - playerSize.y), 
               size: playerSize));
    return super.onLoad();
  }
}

class Background extends SpriteComponent with HasGameReference<FlameGame>{
  late String path;

  Background({super.size, required this.path}):super(
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(path);
    size = size;
  }
}