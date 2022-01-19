import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/domain/usecase/create_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/delete_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/fetch_league_menu_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/fetch_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/get_league_usecase.dart';
import 'package:e_racing_app/league/domain/usecase/upate_league_usecase.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_screen.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LeagueModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LeagueViewModel()),
        Bind.factory((i) => CreateLeagueUseCase<StatusModel>()),
        Bind.factory((i) => FetchLeagueUseCase<List<LeagueModel>>()),
        Bind.factory((i) => UpdateLeagueUseCase<StatusModel>()),
        Bind.factory((i) => GetMediaUseCase<MediaModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetSocialMediaUseCase()),
        Bind.factory((i) => GetLeagueUseCase<LeagueModel>()),
        Bind.factory((i) => DeleteLeagueUseCase<StatusModel>()),
        Bind.factory((i) => FetchLeagueMenuUseCase<List<ShortcutModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LeagueScreen()),
      ];
}
