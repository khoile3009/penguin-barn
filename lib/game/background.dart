import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:penguin_farm/game/assets.dart';
import 'package:penguin_farm/game/penguin_barn.dart';

class Background extends SpriteComponent with HasGameRef<PenguinBarn> {
  Background();

  @override
  Future<void> onLoad() async {
    var fileName = Assets.background;
    final background = await Flame.images.load(fileName);
    // Get the original dimensions of the image
    final imageWidth = background.width.toDouble();
    final imageHeight = background.height.toDouble();

    // Scale to the larger multiplication
    final heightRatio = gameRef.size.y / imageHeight;
    final widthRatio = gameRef.size.x / imageWidth;

    final multiplier = max(heightRatio, widthRatio);
    double newWidth = imageWidth * multiplier;
    double newHeight = imageHeight * multiplier;

    size = Vector2(newWidth, newHeight);

    // Center the sprite
    position = Vector2(
        (gameRef.size.x - newWidth) / 2, (gameRef.size.y - newHeight) / 2);
    sprite = Sprite(background);
  }
}
