import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teto/level.dart';


class MusicRoom extends FlameGame with KeyboardEvents{

  late final SpriteComponent background;
  // late final Player girl;
  final int dirLeft = -1;
  final int dirRight = 1;
  late int direction;

  late final CameraComponent cam;
  final level = Level();

  @override
  Future<void> onLoad() async {
    _setCamera(size);
    addAll([cam, level]);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isLeft = keysPressed.contains(LogicalKeyboardKey.keyA) || 
                   keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRight = keysPressed.contains(LogicalKeyboardKey.keyD) || 
                    keysPressed.contains(LogicalKeyboardKey.arrowRight);

    direction = 0;
    if (isLeft) {
      direction += dirLeft;
    } 
    if (isRight) {
      direction += dirRight;
    }

    return KeyEventResult.handled;
  }

  void _setCamera(Vector2 size) {
    cam = CameraComponent.withFixedResolution(
      world: level, width: size.x, height: size.y);
    cam.viewfinder.anchor = Anchor.topLeft;
    cam.viewfinder.position = Vector2.zero(); // Start from top-left
  }
}



