import 'package:flame_forge2d/flame_forge2d.dart';

List<Wall> createBoundaries(Forge2DGame game) {
  final topLeft = Vector2.zero();
  final bottomRight = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft),
    Wall(bottomLeft, topLeft),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      type: BodyType.static,
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
