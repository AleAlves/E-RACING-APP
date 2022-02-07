import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login/di/login_di.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
      child: ERcaingApp(),
    ));

// ignore: must_be_immutable
class ERcaingApp extends StatelessWidget {

  ThemeMode themeMode = ThemeMode.system;

  ERcaingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.gold;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: usedScheme,
        appBarElevation: 0.5,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        appBarElevation: 2,
      ),
      themeMode: themeMode,
      title: 'E-Racing',
    ).modular();
  }
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: LoginModule()),
      ];
}
