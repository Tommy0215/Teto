import 'dart:async';

import 'package:flame/components.dart';

import 'package:teto/music_room.dart';

enum PlayerState {
  idle, walking
}

class Player extends SpriteAnimationGroupComponent with HasGameReference<MusicRoom>{

  Player({super.position, super.size});

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkingAnimation;
  final double stepTime = 0.1;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }
  
  void _loadAllAnimations() async {
    // Loading all animations
    idleAnimation = await _spriteAnimation('girl_still.png', 1);
    walkingAnimation = await _spriteAnimation('spritesheet.png', 4);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walking: walkingAnimation
    };

    // Set current animation
    current = PlayerState.walking;
  }

  Future<SpriteAnimation> _spriteAnimation(String path, int amount) async {
    return SpriteAnimation.fromFrameData(
     await game.images.load(path), SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: Vector2.all(64)
      )
    );
  }
}