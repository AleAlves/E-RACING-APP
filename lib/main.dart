import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login/di/login_di.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
      child: const ERcaingApp(),
    ));

class ERcaingApp extends StatelessWidget {
  static const MaterialColor ascent = MaterialColor(0xffba1111, <int, Color>{});
  static const MaterialColor base = MaterialColor(0xFF282828, <int, Color>{});
  static const MaterialColor color = MaterialColor(0xFFFFBA60, <int, Color>{
    50: Color(0xFFFEF4E7),
    100: Color(0xFFFCE3C3),
    200: Color(0xFFFAD19C),
    300: Color(0xFFF7BE74),
    400: Color(0xFFF6B056),
    500: Color(0xFFF4A238),
    600: Color(0xFFF39A32),
    700: Color(0xFFF1902B),
    800: Color(0xFFEF8624),
    900: Color(0xFFEC7517),
  });

  const ERcaingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Racing',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(),
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: color, accentColor: ascent)
            .copyWith(secondary: ascent),
      ),
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
