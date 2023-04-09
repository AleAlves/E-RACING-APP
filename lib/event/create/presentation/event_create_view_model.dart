import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/ui/view_state.dart';
import 'navigation/event_create_flow.dart';

part 'event_create_view_model.g.dart';

class EventCreateViewModel = _EventCreateViewModel with _$EventCreateViewModel;

abstract class _EventCreateViewModel extends BaseViewModel<EventCreateNavigator>
    with Store {
  _EventCreateViewModel();

  @override
  @observable
  EventCreateNavigator? flow;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  StatusModel? status;

  @observable
  String? name;

  @observable
  String? rules;

  @observable
  String? banner;

  @observable
  String? date;

  void setAgreement(bool termsAgreement) {
    onNavigate(EventCreateNavigator.name);
  }

  void setEventName(String name) {
    onNavigate(EventCreateNavigator.rules);
  }

  void setEventRules(String rules) {
    onNavigate(EventCreateNavigator.options);
  }

  void setEventDate(String date) {
    onNavigate(EventCreateNavigator.options);
  }
}
