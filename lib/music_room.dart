import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:teto/level.dart';
import 'package:teto/player.dart';


class MusicRoom extends FlameGame with HasKeyboardHandlerComponents{

  late final SpriteComponent background;
  // late final Player girl;
  final int dirLeft = -1;
  final int dirRight = 1;
  late int direction;

  late final CameraComponent cam;
  Player player = Player(size: Vector2.all(128));
  late final Level level;

  @override
  Future<void> onLoad() async {
    level = Level(player: player);
    _setCamera(size);
    addAll([cam, level]);
  }

  void _setCamera(Vector2 size) {
    cam = CameraComponent.withFixedResolution(
      world: level, width: size.x, height: size.y);
    cam.viewfinder.anchor = Anchor.topLeft;
    cam.viewfinder.position = Vector2.zero();
  }
}
