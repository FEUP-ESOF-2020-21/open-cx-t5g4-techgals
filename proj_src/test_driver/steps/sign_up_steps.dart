import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapSignUp extends When1WithWorld<String, FlutterWorld> {
  TapSignUp()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String signup) async {
    final signupfinder = find.byValueKey(signup);
    var signupFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, signupfinder);
    expectMatch(true, signupFinderExists);
    await FlutterDriverUtils.tap(world.driver, signupfinder);
  }

  @override
  RegExp get pattern => RegExp(r"I tap {string}");
}

class TypeUsername extends And1WithWorld<String, FlutterWorld> {
  TypeUsername()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String username) async {
    final usernamefinder = find.byValueKey(username);
    var usernameFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, usernamefinder);
    expectMatch(true, usernameFinderExists);
    await FlutterDriverUtils.tap(world.driver, usernamefinder);
  }

  @override
  RegExp get pattern => RegExp(r"I type {string}");
}

class TapSignupButton extends And1WithWorld<String, FlutterWorld> {
  TapSignupButton()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String signupbtn) async {
    final signupbtnfinder = find.byValueKey(signupbtn);
    var signupbtnFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, signupbtnfinder);
    expectMatch(true, signupbtnFinderExists);
    await FlutterDriverUtils.tap(world.driver, signupbtnfinder);
  }

  @override
  RegExp get pattern => RegExp(r"I tap {string}");
}

class GoToNavigationPageFromSignup extends ThenWithWorld<FlutterWorld> {
  GoToNavigationPageFromSignup()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I should be successfully signed up");
}
