import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/domain/fetch_events_use_case.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'presentation/ui/event_flow.dart';

part 'event_view_model.g.dart';

class EventViewModel = _EventViewModel with _$EventViewModel;

abstract class _EventViewModel with Store {
  _EventViewModel();

  @observable
  EventModel? event;

  @observable
  MediaModel? media;

  @observable
  String? id;

  @observable
  StatusModel? status;

  @observable
  EventFlow flow = EventFlow.list;

  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<ShortcutModel>? menus = ObservableList();

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<SocialPlatformModel?>? socialMedias = ObservableList();

  final getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel>>();
  final getTagUseCase = Modular.get<GetTagUseCase>();
  final getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();
  final fetchEventsUseCase = Modular.get<FetchEventsUseCase<List<EventModel>>>();

  @action
  init() async {
    state = ViewState.ready;
  }

  void fetchEvents() async {
    state = ViewState.loading;
    fetchEventsUseCase.invoke(
        success: (data) {
          events = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void getMedia(String id) async {
    await getMediaUseCase.params(id: id).invoke(
        success: (data) {
          media = data;
        },
        error: onError);
  }

  void fetchTags() async {
    state = ViewState.loading;
    await getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    await getSocialMediaUseCase.invoke(
        success: (data) {
          socialMedias = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void deeplink({String? deepLink, EventFlow? flow}) {
    if (deepLink != null) {
      Modular.to.pushNamed(deepLink);
    } else if (flow != null) {
      setFlow(flow);
    }
  }

  void onError(ApiException error) {
    status = StatusModel(
      message: error.message(),
      action: "Ok",
      next: EventFlow.list,
      previous: flow,
    );
    if (error.isBusiness()) {
      state = ViewState.ready;
      flow = EventFlow.status;
    } else {
      state = ViewState.error;
    }
  }

  void setFlow(EventFlow flow) {
    this.flow = flow;
  }
}
