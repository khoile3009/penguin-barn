import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:penguin_farm/game/background.dart';
import 'package:penguin_farm/game/iceberg.dart';
import 'package:penguin_farm/game/penguin.dart';

class PenguinBarn extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    addAll([Background(), Iceberg(), Penguin()]);
  }
}
