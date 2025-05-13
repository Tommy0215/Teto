import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:teto/components/level.dart';
import 'package:teto/components/player.dart';


class MusicRoom extends FlameGame 
  with HasKeyboardHandlerComponents, DragCallbacks, TapCallbacks{

  late Timer _joystickHideTimer;

  late final SpriteComponent background;
  // late final Player girl;
  final int dirLeft = -1;
  final int dirRight = 1;
  late int direction;

  late final CameraComponent cam;
  Player player = Player();
  late final Level level;
  late JoystickComponent joystick;

  // Loading elements
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();

    level = Level(player: player);

    _setCamera(size);

    addAll([cam, level]);

    addJoystick();
  }

  // Updating the game
  @override
  void update(double dt) {
    updateJoystick();
    _joystickHideTimer.update(dt);
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {

    // Can group this in a method
    joystick.position = event.canvasPosition;
    joystick.priority = cam.priority + 1;
    _joystickHideTimer.stop();
    _joystickHideTimer.start();

    super.onTapDown(event);
  }


  void _setCamera(Vector2 size) {
    cam = CameraComponent.withFixedResolution(
      world: level, width: size.x, height: size.y);
    cam.viewfinder.anchor = Anchor.topLeft;
    // cam.viewfinder.position = Vector2.zero();
  }
  
  void addJoystick() {
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.white.withAlpha(100)),
      background: CircleComponent(radius: 40, paint: Paint()..color = Colors.grey.withValues(alpha: .25)),
      // margin: const EdgeInsets.only(left: 32, bottom: 32),
      position: size/2,
      priority: cam.priority-1 // Can change this to hide when not needed
    );
    add(joystick);

    _joystickHideTimer = Timer(1, onTick: () {
      joystick.priority = cam.priority-1;
    });
  }

  void updateJoystick() {
    if (joystick.delta != Vector2.zero()) {
      _joystickHideTimer.stop();
      _joystickHideTimer.start();
    }

    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
