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
  static const MaterialColor color = MaterialColor(0xFFFFC515, <int, Color>{
    50: Color(0xFFFFF8E3),
    100: Color(0xFFFFEEB9),
    200: Color(0xFFFFE28A),
    300: Color(0xFFFFD65B),
    400: Color(0xFFFFCE38),
    500: Color(0xFFFFC515),
    600: Color(0xFFFFBF12),
    700: Color(0xFFFFB80F),
    800: Color(0xFFFFB00C),
    900: Color(0xFFFFA306),

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
