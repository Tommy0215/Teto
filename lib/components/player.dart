import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:teto/music_room.dart';

enum PlayerState {idle, walking}

enum PlayerDirection {left, right, none}

class Player extends SpriteAnimationGroupComponent with 
  HasGameReference<MusicRoom>, KeyboardHandler{

  Player({super.position});

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkingAnimation;
  final double stepTime = 0.1;
  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || 
      keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || 
      keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isLeftKeyPressed && isRightKeyPressed){
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      // Can be changed depending on the game
      playerDirection = PlayerDirection.none;
    }
    
    return super.onKeyEvent(event, keysPressed);
  }
  
  void _loadAllAnimations() async {
    // Loading all animations
    idleAnimation = _spriteAnimation('girl_still.png', 1);
    walkingAnimation = _spriteAnimation('spritesheet.png', 4);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walking: walkingAnimation
    };

    // Set current animation
    current = PlayerState.walking;
  }

  SpriteAnimation _spriteAnimation(String path, int amount){
    return SpriteAnimation.fromFrameData(
        game.images.fromCache(path), SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: Vector2.all(64)
      )
    );
  }
  
  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    switch(playerDirection){
      case PlayerDirection.left:
        if(isFacingRight){
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        current = PlayerState.walking;
        dirX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        current = PlayerState.walking;
        dirX += moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
    }

    velocity = Vector2(dirX, 0);
    position += velocity * dt;
  }
}