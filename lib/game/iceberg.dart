import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:penguin_farm/game/assets.dart';
import 'package:penguin_farm/game/constants.dart';
import 'package:penguin_farm/game/penguin_barn.dart';

class Iceberg extends SpriteComponent with HasGameRef<PenguinBarn> {
  Iceberg();

  @override
  Future<void> onLoad() async {
    var fileName = Assets.iceberg;
    final iceberg = await Flame.images.load(fileName);
    // Get the original dimensions of the image
    final imageWidth = iceberg.width.toDouble();
    final imageHeight = iceberg.height.toDouble();

    // Scale to the larger multiplication
    final heightRatio =
        gameRef.size.y / imageHeight * Constants.icebergToScreenRatio;
    final widthRatio =
        gameRef.size.x / imageWidth * Constants.icebergToScreenRatio;

    final multiplier = min(heightRatio, widthRatio);

    double newWidth = imageWidth * multiplier;
    double newHeight = imageHeight * multiplier;

    size = Vector2(newWidth, newHeight);
    // Center the sprite
    position = Vector2(
        (gameRef.size.x - newWidth) / 2, (gameRef.size.y - newHeight) / 2);
    sprite = Sprite(iceberg);
  }
}
