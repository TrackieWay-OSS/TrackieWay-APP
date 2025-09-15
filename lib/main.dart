import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackie_app/app/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const App());
}


