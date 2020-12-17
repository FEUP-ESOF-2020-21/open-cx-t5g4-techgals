import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class AtWelcomePage extends Given1WithWorld<String, FlutterWorld> {
  AtWelcomePage()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String welcomepage) async {
    final welcomepagefinder = find.byValueKey(welcomepage);
    var welcomepageFinderExists =
        await FlutterDriverUtils.isPresent(world.driver, welcomepagefinder);
    expectMatch(true, welcomepageFinderExists);
    await FlutterDriverUtils.tap(world.driver, welcomepagefinder);
  }

  @override
  RegExp get pattern => RegExp(r"I am at the {string}");
}

class TypeEmail extends And1WithWorld<String, FlutterWorld> {
  TypeEmail()
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
  RegExp get pattern => RegExp(r"I type {string}");
}

class TypePassword extends And1WithWorld<String, FlutterWorld> {
  TypePassword()
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
  RegExp get pattern => RegExp(r"I type {string}");
}
