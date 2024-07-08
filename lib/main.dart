import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:penguin_farm/game/penguin_barn.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  PenguinBarn game = PenguinBarn();
  runApp(GameWidget(game: kDebugMode ? PenguinBarn() : game));
}
