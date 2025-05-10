import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();

 runApp(
  GameWidget(game: MyGame())
 );
}

class MyGame extends FlameGame with KeyboardEvents{

  late final SpriteComponent background;
  late final Player girl;

  final int dirLeft = -1;
  final int dirRight = 1;
  late int direction;

  @override
  Future<void> onLoad() async {
    girl = Player(position: size/2);

    add(Background(size: size));
    add(girl);
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

    girl.walk(direction);

    return KeyEventResult.handled;
  }
}

class Player extends SpriteComponent{

  int moveDirection = 0; // -1 = left, 1 = right, 0 = idle

  Player({super.position}) : 
    super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('right/girl_right_1.png');
  }

  void walk(int direction){
    moveDirection = direction;
  }
  
  @override
  void update(double dt) {
    position.x += moveDirection * 100 * dt;
  }

  
}

class Background extends SpriteComponent {
  Background({super.size});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('horror.jpeg');
  }
}
