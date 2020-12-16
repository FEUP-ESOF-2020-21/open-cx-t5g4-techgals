import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/common_steps.dart';
import 'steps/log_in_steps.dart';
import 'steps/sign_up_steps.dart';

Future<void> main() {
  /* final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = []
    ..stepDefinitions = [
      TapEmail(),
      TapPassword(),
      TapLoginButton(),
      GoToNavigationPage(),
      TapSignupButton(),
      InsertNewEmail(),
      TapUsername(),
      ExpectToSignup()
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true;
  return GherkinRunner().execute(config);
}*/

  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..stepDefinitions = [
      AtWelcomePage(),
      TapLogin(),
      TypeEmail(),
      TypePassword(),
      TapLoginButton(),
      GoToNavigationPageFromLogin(),
      TapSignUp(),
      TypeUsername(),
      TapSignupButton(),
      GoToNavigationPageFromSignup()
    ]
    ..reporters = [ProgressReporter(), TestRunSummaryReporter()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true;

  return GherkinRunner().execute(config);
}
