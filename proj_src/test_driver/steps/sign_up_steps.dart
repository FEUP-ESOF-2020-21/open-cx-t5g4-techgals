import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ExpectToSignup extends Given1WithWorld<String, FlutterWorld> {
  ExpectToSignup()
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
  RegExp get pattern => RegExp(r"I tapped the {string} in the homepage");
}

class TapUsername extends When1WithWorld<String, FlutterWorld> {
  TapUsername()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String email) async {
    final emailfinder = find.byValueKey(email);
    var emailFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, emailfinder);
    expectMatch(true, emailFinderExists);
    await FlutterDriverUtils.tap(world.driver, emailfinder);
  }

  @override
  RegExp get pattern => RegExp(r"User types {string}");
}

class InsertNewEmail extends And1WithWorld<String, FlutterWorld> {
  InsertNewEmail()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String email) async {
    final emailfinder = find.byValueKey(email);
    var emailFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, emailfinder);
    expectMatch(true, emailFinderExists);
    await FlutterDriverUtils.tap(world.driver, emailfinder);
  }

  @override
  RegExp get pattern => RegExp(r"User types {string}");
}

class TapSignupButton extends And1WithWorld<String, FlutterWorld> {
  TapSignupButton()
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
  RegExp get pattern => RegExp(r"User taps {string}");
}
