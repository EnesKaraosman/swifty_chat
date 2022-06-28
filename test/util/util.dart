import 'package:flutter_test/flutter_test.dart';

Future wait(int milliseconds) {
  return Future.delayed(Duration(milliseconds: milliseconds), () {});
}

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}
