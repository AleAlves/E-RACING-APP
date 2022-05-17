import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login/di/login_di.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
      child: const ERcaingApp(),
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
      secondary: Color(0xFF6D0F78),
      secondaryVariant: Color(0xFF6D0F78),
    );

    const FlexSchemeData _myFlexScheme = FlexSchemeData(
      name: 'Midnight blue',
      description: 'Midnight blue theme, custom definition of all colors',
      light: color,
      dark: color,
    );

    return MaterialApp.router(
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
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
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
