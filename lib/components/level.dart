import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:teto/music_room.dart';
import 'package:teto/components/player.dart';

class Level extends World with HasGameReference<MusicRoom>{
  
  late Background horrorBackground;
  final Player player;

  Level({required this.player}):super(priority: 10);

  @override
  FutureOr<void> onLoad() {

    horrorBackground = Background(size: game.size, path: 'background/horror2.jpeg');
    add(horrorBackground);

      // Set player size relative to screen height, e.g., 10% of height
    player.size = Vector2.all(game.size.y * 0.3);
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
