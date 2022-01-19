import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login/di/login_di.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
      child: const ERcaingApp(),
    ));

class ERcaingApp extends StatelessWidget {
  static const MaterialColor color = MaterialColor(0xFF210063, <int, Color>{
    10: Color(0xffe7e7e7),
    20: Color(0xfffcfcfc),
    30: Color(0xFF391B76),
    50: Color(0xFFF3E5F5),
    100: Color(0xffba1111),
    200: Color(0xffff5e5e),
    300: Color(0xFFBA68C8),
    400: Color(0xFFAB47BC),
    500: Color(0xFF522AA3),
    600: Color(0xFF8E24AA),
    700: Color(0xFF7B1FA2),
    800: Color(0xFF6A1B9A),
    900: Color(0xFF4A148C),
  });
  final Color primaryDar = const Color(0x42000000);
  final Color primary = const Color(0xFF232323);

  const ERcaingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Racing',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: color, accentColor: color.shade100)
            .copyWith(secondary: color.shade100),
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
