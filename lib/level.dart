import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:teto/music_room.dart';
import 'package:teto/player.dart';

class Level extends World with HasGameReference<MusicRoom>{
  
  late Background horrorBackground;
  final Player player;

  Level({required this.player});

  @override
  FutureOr<void> onLoad() {

    horrorBackground = Background(size: game.size, path: 'horror.jpeg');
    add(horrorBackground);

    player.position = Vector2(0, (game.size.y*0.9)-player.size.y);
    add(player);
    
    return super.onLoad();
  }
}


class Background extends SpriteComponent with HasGameReference<FlameGame>{
  late String path;

  Background({super.size, required this.path}):super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(path);
    size = size;
  }
}
