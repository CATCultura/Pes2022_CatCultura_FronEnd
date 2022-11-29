import 'package:CatCultura/utils/Session.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  test('Session should store value', () {
    final session = Session();

    session.set("test",15);

    expect(session.get("test"), 15);
  });

  test('Singleton test', () {
    final session = Session();

    session.set("test",15);

    final new_session = Session();

    expect(session.get("test"), new_session.get("test"));
  });



}