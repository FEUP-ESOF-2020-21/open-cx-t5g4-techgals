import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapPassword extends And1WithWorld<String, FlutterWorld> {
  TapPassword()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String password) async {
    final passwordfinder = find.byValueKey(password);
    var passwordFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, passwordfinder);
    expectMatch(true, passwordFinderExists);
    await FlutterDriverUtils.tap(world.driver, passwordfinder);
  }

  @override
  RegExp get pattern => RegExp(r"User types {string}");
}

class GoToNavigationPage extends ThenWithWorld<FlutterWorld> {
  GoToNavigationPage()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"User should be successfully logged");
}
