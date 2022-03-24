import 'package:flutter/material.dart';
import 'package:game_new_scene/entities/flower.dart';
import 'package:game_new_scene/entities/fly.dart';
import 'package:game_new_scene/scenes/app_scene.dart';
import 'package:game_new_scene/utilits/global_vars.dart';

import '../utilits/global_vars.dart';

class GameScene extends AppScene {
  Player _player = Player();
  double _startGlobalPosition = 0;
  final List<Bullet> _listBullets = [];
  List<Widget> _listWidgets = [];

  @override
  Widget buildScene() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
            top: 0,
            left: 0,
            child: Stack(
              children: [
                Positioned(
                  top: GlobalVars.screenHeight / 2,
                  left: GlobalVars.screenWidth / 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.white70.withOpacity(0.2),
                    child: const Text(
                      'Свайпай тут влево-вправо',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.green)),
                  width: GlobalVars.screenWidth / 2,
                  height: GlobalVars.screenHeight,
                  child: GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                  ),
                ),
              ],
            )),
        Positioned(
            top: 0,
            left: GlobalVars.screenWidth / 2,
            child: Stack(
              children: [
                Positioned(
                  top: GlobalVars.screenHeight / 4,
                  left: GlobalVars.screenWidth / 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.white70.withOpacity(0.2),
                    child: const Text(
                      'Тапни тут, чтобы испугать его',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.green)),
                  width: GlobalVars.screenWidth / 2,
                  height: GlobalVars.screenHeight / 2,
                  child: GestureDetector(
                    onTap: _onAcceleration,
                  ),
                ),
              ],
            )),
        Positioned(
            top: GlobalVars.screenHeight / 2,
            left: GlobalVars.screenWidth / 2,
            child: Stack(
              children: [
                Positioned(
                  top: GlobalVars.screenHeight / 4,
                  left: GlobalVars.screenWidth / 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.white70.withOpacity(0.2),
                    child: Text(
                      'Тапни ниже и таракан наследит',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.blue)),
                  width: GlobalVars.screenWidth / 2,
                  height: GlobalVars.screenHeight / 2,
                  child: GestureDetector(
                    onTap: _onShoot,
                  ),
                ),
              ],
            )),
        Stack(
          children: _listWidgets,
        )
      ],
    );
  }

  @override
  void update() {
    _player.update();
    _listWidgets.clear();
    _listBullets.removeWhere((element) => !element.visible);
    _listBullets.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });
  }

  GameScene();

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
    print(_startGlobalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;
    if (updateGlobalPosition > _startGlobalPosition + 30) {
      _player.isMoveRight = true;
    }

    if (updateGlobalPosition < _startGlobalPosition - 30) {
      _player.isMoveLeft = true;
    }
  }

  void _onAcceleration() {
    _player.isAcceleration = _player.isAcceleration ? false : true;
  }

  void _onShoot() {
    _listBullets.add(Bullet(
        playerAngle: _player.getAngle, playerX: _player.x, playerY: _player.y));
  }
}
