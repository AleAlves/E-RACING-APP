import 'package:e_racing_app/core/tools/routes.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'core/tools/session.dart';
import 'login/di/login_di.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Session.instance.setFCMToken(await FirebaseMessaging.instance.getToken());
  await FirebaseMessaging.instance.setAutoInitEnabled(false);
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    Session.instance.setFCMToken(fcmToken);
    print("TOKEN FCM:" + fcmToken);
  }).onError((err) {
    print(err);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
  });

  runApp(ModularApp(
    module: AppModule(),
    child: I18n(initialLocale: const Locale("pt"), child: const ERacingApp()),
  ));
}

class ERacingApp extends StatefulWidget {
  const ERacingApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ERacingAppState();
}

class _ERacingAppState extends State<ERacingApp> {
  final ThemeMode themeMode = ThemeMode.system;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('######## Dynamic Link #########');
      print(dynamicLinkData.link);
      print(dynamicLinkData.link.path);
      Session.instance
          .setLeagueId(dynamicLinkData.link.queryParameters['leagueId']);
      Session.instance
          .setEventId(dynamicLinkData.link.queryParameters['eventId']);
      if (Session.instance.getBearerToken() != null) {
        Modular.to
            .pushNamed(dynamicLinkData.link.queryParameters['route'] ?? '');
      } else {
        Session.instance.setOnDeeplinkFlow(true);
        Session.instance.setDeeplink(Routes.event);
      }
    }).onError((error) {
      print('######## Dynamic Link Error #########');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    const FlexSchemeColor colorDark = FlexSchemeColor(
      primary: Color(0xFFFFA94C),
      primaryVariant: Color(0xFFF68D1C),
      secondary: Color(0xFF7A2491),
      secondaryVariant: Color(0xFF7A2491),
    );

    const FlexSchemeColor colorLight = FlexSchemeColor(
      primary: Color(0xFFFF9E37),
      primaryVariant: Color(0xFFF68D1C),
      secondary: Color(0xFF7A2491),
      secondaryVariant: Color(0xFF7A2491),
    );

    const FlexSchemeData _myFlexScheme = FlexSchemeData(
      name: 'Midnight blue',
      description: 'Midnight blue theme, custom definition of all colors',
      light: colorLight,
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
        colors: _myFlexScheme.light,
        appBarElevation: 0.1,
      ).copyWith(
          iconTheme: const IconThemeData(color: Color(0xFF676767)),
          cardColor: const Color(0xFFEFEFEF),
          focusColor: const Color(0xFFD7D7D7)),
      darkTheme: FlexThemeData.dark(
        colors: _myFlexScheme.dark,
        appBarElevation: 0.1,
      ).copyWith(
          iconTheme: const IconThemeData(color: Color(0xFF676767)),
          cardColor: const Color(0xFF1C1C1C),
          focusColor: const Color(0xFF2C2A2A)),
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
  List<ModularRoute> get routes => [ModuleRoute("/", module: LoginModule())];
}
