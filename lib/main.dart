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
  static const MaterialColor color = MaterialColor(0xFF6FA8DC, <int, Color>{
    50: Color(0xFFEEF5FB),
    100: Color(0xFFD4E5F5),
    200: Color(0xFFB7D4EE),
    300: Color(0xFF9AC2E7),
    400: Color(0xFF85B5E1),
    500: Color(0xFF6FA8DC),
    600: Color(0xFF67A0D8),
    700: Color(0xFF5C97D3),
    800: Color(0xFF528DCE),
    900: Color(0xFF407DC5),
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
