import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ExpectToLogin extends GivenWithWorld<FlutterWorld> {
  ExpectToLogin()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I tapped the login button in the homepage");
}

class TapEmail extends When1WithWorld<String, FlutterWorld> {
  TapEmail()
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
  RegExp get pattern => RegExp(r"User taps {string}");
}
