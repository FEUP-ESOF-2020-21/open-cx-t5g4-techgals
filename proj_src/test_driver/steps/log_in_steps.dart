import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapLogin extends When1WithWorld<String, FlutterWorld> {
  TapLogin()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String login) async {
    final loginfinder = find.byValueKey(login);
    var loginFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, loginfinder);
    expectMatch(true, loginFinderExists);
    await FlutterDriverUtils.tap(world.driver, loginfinder);
  }

  @override
  RegExp get pattern => RegExp(r"I tap {string}");
}

class TapLoginButton extends And1WithWorld<String, FlutterWorld> {
  TapLoginButton()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String loginbtn) async {
    final loginbtnfinder = find.byValueKey(loginbtn);
    var loginbtnFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, loginbtnfinder);
    expectMatch(true, loginbtnFinderExists);
    await FlutterDriverUtils.tap(world.driver, loginbtnfinder);
  }

  @override
  RegExp get pattern => RegExp(r"I tap {string}");
}

class GoToNavigationPageFromLogin extends ThenWithWorld<FlutterWorld> {
  GoToNavigationPageFromLogin()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I should be successfully logged");
}
