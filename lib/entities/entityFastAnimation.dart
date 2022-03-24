import 'package:flutter/cupertino.dart';

abstract class Entity {
  double x = 0;
  double y = 0;
  final String spriteName;
  bool visible = true;
  List sprites = [];
  int currentSprite = 0;
  int currentTick = 0;

  Entity(this.spriteName) {
    for (var i = 0; i < 18; i++) {
      sprites.add(Image.asset("assets/$spriteName$i.png"));
    }
  }

  //  реализовываю анимацию, приватна, потом что инкапсулируем в классе entity
  // и другие классы не должны знать о том как реализовывается анимация
  void _animate() {
    // метод анимации
    currentTick++;
    if (currentTick > 0.2) {
      currentSprite++; // на каждой итерации цикла
      currentTick = 0;
    }
    if (currentSprite > 17) {
      currentSprite = 0;
    }
  }

  void update() {
    _animate();
    move();
  }

  void move();

  Widget build();
}
