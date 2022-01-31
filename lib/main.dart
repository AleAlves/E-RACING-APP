import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login/di/login_di.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
      child: const ERcaingApp(),
    ));

class ERcaingApp extends StatelessWidget {
  static const MaterialColor ascent = MaterialColor(0xffba1111, <int, Color>{});
  static const MaterialColor color = MaterialColor(0xFFFFBA60, <int, Color>{
    50: Color(0xFFFFF7EC),
    100: Color(0xFFFFEACF),
    200: Color(0xFFFFDDB0),
    300: Color(0xFFFFCF90),
    400: Color(0xFFFFC478),
    500: Color(0xFFFFBA60),
    600: Color(0xFFFFB358),
    700: Color(0xFFFFAB4E),
    800: Color(0xFFFFA344),
    900: Color(0xFFFF9433),
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
