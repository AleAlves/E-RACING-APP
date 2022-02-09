import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login/di/login_di.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
      child: ERcaingApp(),
    ));


class ERcaingApp extends StatelessWidget {

  final ThemeMode themeMode = ThemeMode.system;

  const ERcaingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.amber;

    const FlexSchemeColor color = FlexSchemeColor(
      primary: Color(0xFFFFA94C),
      primaryVariant: Color(0xFFF68D1C),
      secondary: Color(0xFF1A246C),
      secondaryVariant: Color(0xFF1A246C),
    );

    const FlexSchemeData _myFlexScheme = FlexSchemeData(
      name: 'Midnight blue',
      description: 'Midnight blue theme, custom definition of all colors',
      light: color,
      dark: color,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: usedScheme,
        colors: _myFlexScheme.light,
        appBarElevation: 0.5,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        colors: _myFlexScheme.dark,
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
