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
  static const MaterialColor color = MaterialColor(0xFFF6B26B, <int, Color>{
    50: Color(0xFFFEF6ED),
    100: Color(0xFFFCE8D3),
    200: Color(0xFFFBD9B5),
    300: Color(0xFFF9C997),
    400: Color(0xFFF7BE81),
    500: Color(0xFFF6B26B),
    600: Color(0xFFF5AB63),
    700: Color(0xFFF3A258),
    800: Color(0xFFF2994E),
    900: Color(0xFFEF8A3C),
  });

  const ERcaingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Racing',
      theme: ThemeData.dark().copyWith(
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
