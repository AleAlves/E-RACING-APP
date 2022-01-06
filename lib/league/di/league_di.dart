import 'package:e_racing_app/league/presentation/ui/league_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LeagueModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const LeagueScreen()),
  ];
}