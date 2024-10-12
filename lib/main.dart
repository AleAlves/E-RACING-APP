import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import './firebase_options.dart';
import 'app/di/app_main_di.dart';
import 'core/tools/session.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Session.instance.setFCMToken(await FirebaseMessaging.instance.getToken());
  await FirebaseMessaging.instance.setAutoInitEnabled(false);
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    Session.instance.setFCMToken(fcmToken);
    print("TOKEN FCM:$fcmToken");
  }).onError((err) {
    print(err);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
  });

  runApp(ModularApp(module: AppMainModule(), child: const ERacingApp()));
}

class ERacingApp extends StatefulWidget {
  const ERacingApp({super.key});

  @override
  State<StatefulWidget> createState() => _ERacingAppState();
}

class _ERacingAppState extends State<ERacingApp> {
  final ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const FlexSchemeColor colorDark = FlexSchemeColor(
      primary: Color(0xffffb120),
      primaryContainer: Color(0xffffb120),
      secondary: Color(0xff3a1269),
      secondaryContainer: Color(0xff3a1269),
    );

    const FlexSchemeData myFlexScheme = FlexSchemeData(
      name: 'bigStone',
      description: '',
      light: colorDark,
      dark: colorDark,
    );

    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
      ],
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        colors: myFlexScheme.dark,
        appBarElevation: 0.1,
      ).copyWith(
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color(0xFF1C1C1C)),
          cardColor: const Color(0xFFF6F6F6),
          focusColor: const Color(0xFFE5E1E1)),
      darkTheme: FlexThemeData.dark(
        colors: myFlexScheme.dark,
        appBarElevation: 0.1,
        appBarBackground: Colors.black,
      ).copyWith(
          scaffoldBackgroundColor: Colors.black26,
          iconTheme: const IconThemeData(color: Color(0xFF6B6B6B)),
          cardColor: const Color(0xFF101010),
          focusColor: const Color(0xFF262626)),
      themeMode: themeMode,
      title: 'E-Racing',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
