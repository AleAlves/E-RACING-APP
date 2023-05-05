import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/league/trophies/domain/model/podium_model.dart';
import 'package:e_racing_app/league/trophies/presentation/router/league_trophies_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/tools/session.dart';
import '../domain/get_trophies_usecase.dart';

part 'league_trophies_view_model.g.dart';

class LeagueTrophiesViewModel = _LeagueTrophiesViewModel
    with _$LeagueTrophiesViewModel;

abstract class _LeagueTrophiesViewModel
    extends BaseViewModel<LeagueTrophiesRouter> with Store {
  _LeagueTrophiesViewModel();

  @observable
  MediaModel? media;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title = "Trophy room";

  @override
  @observable
  LeagueTrophiesRouter? flow = LeagueTrophiesRouter.main;

  @override
  @observable
  ViewState state = ViewState.loading;

  @observable
  ObservableList<PodiumModel?>? podiums;

  final _trophiesUC = Modular.get<GetTrophiesUseCase<List<PodiumModel>>>();

  getTrophies() {
    state = ViewState.loading;
    _trophiesUC.build(leagueId: Session.instance.getLeagueId() ?? '').invoke(
        success: (data) {
          podiums = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: onError);
  }

  gotToEvent(String? eventId) {
    Session.instance.setEventId(eventId);
    Modular.to.pushNamed(EventRouter.detail);
  }
}
