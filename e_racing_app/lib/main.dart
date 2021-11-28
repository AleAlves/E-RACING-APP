import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/tools/crypto/crypto_service.dart';
import 'core/tools/session.dart';
import 'login/presentation/ui/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(ERcaingApp());
  });
}

class ERcaingApp extends StatelessWidget {
  static const MaterialColor color = MaterialColor(0xFF391B76, <int, Color>{
    50: Color(0xFFF3E5F5),
    100: Color(0xFFE1BEE7),
    200: Color(0xFFCE93D8),
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
    Session.instance.setKeyChain(CryptoService.instance.generateAESKeys());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Racing',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        primarySwatch: color,
        accentColor: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
      },
    );
  }
}
