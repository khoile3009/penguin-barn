import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:penguin_farm/game/assets.dart';
import 'package:penguin_farm/game/constants.dart';
import 'package:penguin_farm/game/penguin_barn.dart';

enum PenguinState {
  move(rotateAnimationAngle: pi / 36),
  idle(rotateAnimationAngle: 0);

  const PenguinState({required this.rotateAnimationAngle});
  final double rotateAnimationAngle;
}

class Penguin extends SpriteComponent with HasGameRef<PenguinBarn> {
  Penguin();

  PenguinState state = PenguinState.idle;
  Vector2 destination = Vector2(0, 0);
  Vector2 movableOffset = Vector2(0, 0);
  Vector2 mapCenter = Vector2(0, 0);
  double velocity = 50;
  double timer = 0;
  double lastChangeActionTime = 0;

  int changeActionInterval = 5;
  int currentRotateDirection = 1;
  @override
  Future<void> onLoad() async {
    var fileName = Assets.basePenguinStage3;
    final image = await Flame.images.load(fileName);
    // Get the original dimensions of the image
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();

    // Scale to the larger multiplication
    final heightRatio =
        gameRef.size.y / imageHeight * Constants.penguinToScreenRatio;
    final widthRatio =
        gameRef.size.x / imageWidth * Constants.penguinToScreenRatio;

    final multiplier = min(heightRatio, widthRatio);

    double newWidth = imageWidth * multiplier;
    double newHeight = imageHeight * multiplier;

    size = Vector2(newWidth, newHeight);
    // Center the sprite
    mapCenter = Vector2(
        (gameRef.size.x - newWidth) / 2, (gameRef.size.y - newHeight) / 2);

    movableOffset = Vector2(imageWidth * 3, imageHeight * 1.6);
    position = randomDestination();
    sprite = Sprite(image);
  }

  rotate(double dt) {}

  moveTo(Vector2 location, double dt) {
    final targetVector = location - position;
    final direction = targetVector.normalized();
    position += direction * dt * velocity;
  }

  Vector2 randomDestination() {
    Random random = Random();
    double randomOffsetX =
        random.nextDouble() * 2 * movableOffset.x - movableOffset.x;
    double randomOffsetY =
        random.nextDouble() * 2 * movableOffset.y - movableOffset.y;
    return mapCenter + Vector2(randomOffsetX, randomOffsetY);
  }

  bool reachDestination() {
    return (destination - position).length < 0.001 * gameRef.size.y;
  }

  animate(double dt) {
    if (state.rotateAnimationAngle != 0) {
      angle += currentRotateDirection * dt * 0.2;
      if ((angle - state.rotateAnimationAngle * currentRotateDirection).abs() <
          0.01) {
        currentRotateDirection *= -1;
      }
    }
  }

  @override
  update(double dt) {
    super.update(dt);
    timer += dt;

    animate(dt);
    if (timer - lastChangeActionTime > changeActionInterval) {
      state = PenguinState.move;
      destination = randomDestination();
      lastChangeActionTime = timer;
    }
    if (state == PenguinState.move) {
      moveTo(destination, dt);
      if (reachDestination()) {
        state = PenguinState.idle;
      }
    }
  }
}
