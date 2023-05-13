import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_race_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/simple_standings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/subscription_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ext/dialog_extension.dart';
import '../../../../core/model/event_model.dart';
import '../../../../core/tools/session.dart';
import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../../core/ui/component/ui/icon_widget.dart';
import '../event_detail_view_model.dart';

class EventDetailView extends StatefulWidget {
  final EventDetailViewModel viewModel;

  const EventDetailView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailViewState createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView>
    implements BaseSateWidget {
  String? classId;

  @override
  void initState() {
    if (widget.viewModel.event == null) {
      widget.viewModel.getEvent();
    }
    widget.viewModel.title = "Events";
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      state: widget.viewModel.state,
      onBackPressed: onBackPressed,
      floatAction: actionButton(),
      bottom: doRegisterButton(),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }

  @override
  Widget content() {
    return Stack(
      children: [
        Column(
          children: [
            const SpacingWidget(LayoutSize.size16),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: info(),
            ),
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: races(),
            ),
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: standings(),
            ),
            const SpacingWidget(LayoutSize.size48),
          ],
        ),
      ],
    );
  }

  Widget info() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BannerWidget(media: widget.viewModel.eventBanner),
        ),
        const SpacingWidget(LayoutSize.size32),
        title(),
        const SpacingWidget(LayoutSize.size16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: eventStatusWidget(widget.viewModel.event?.state),
        ),
        const SpacingWidget(LayoutSize.size8),
        ButtonWidget(
            enabled: true,
            type: ButtonType.link,
            label: "Event details",
            onPressed: () {
              widget.viewModel.onRoute(EventDetailRouter.info);
            }),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            TextWidget(
              text: widget.viewModel.event?.title,
              style: Style.title,
              align: TextAlign.start,
            )
          ],
        ),
      ),
    );
  }

  Widget eventStatusWidget(EventState? state) {
    var color;
    var status;
    switch (state) {
      case EventState.idle:
        color = Colors.grey;
        status = "Preparing";
        break;
      case EventState.ready:
        color = Colors.amber;
        status = "Ready";
        break;
      case EventState.ongoing:
        color = Colors.green;
        status = "On going";
        break;
      case EventState.finished:
        color = Colors.red;
        status = "Finished";
        break;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconWidget(
              icon: Icons.circle,
              color: color,
            ),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(text: status, style: Style.paragraph),
          ],
        ),
      ],
    );
  }

  FloatActionButtonWidget? actionButton() {
    return isEventHost(widget.viewModel.event)
        ? adminOption()
        : cancelRegistration();
  }

  FloatActionButtonWidget? cancelRegistration() {
    return _hasRegistration()
        ? FloatActionButtonWidget(
            icon: Icons.person_remove,
            title: "",
            onPressed: () {
              confirmationDialogExt(
                context: context,
                issueMessage: "Do you want to cancel your registration?",
                consentMessage: "Yes, I do",
                onPositive: () {
                  widget.viewModel.unsubscribe(classId);
                },
              );
            },
          )
        : null;
  }

  FloatActionButtonWidget? adminOption() {
    return FloatActionButtonWidget(
      icon: Icons.manage_accounts,
      title: "Manage",
      onPressed: () {
        Modular.to.pushNamed(EventRouter.manage);
      },
    );
  }

  Widget status() {
    return EventProgressWidget(
      shapeless: true,
      event: widget.viewModel.event,
    );
  }

  Widget races() {
    return EventRaceCollection(
        onRaceCardPressed: (id) {
          widget.viewModel.goToRace(id);
        },
        races: widget.viewModel.event?.races);
  }

  Widget standings() {
    return SimpleStandingsWidget(
      standings: widget.viewModel.standings,
      onRaceCardPressed: (id) {},
      onFullStandingsPressed: () {
        widget.viewModel.onRoute(EventDetailRouter.standings);
      },
    );
  }

  Widget? doRegisterButton() {
    return widget.viewModel.event?.joinable == true
        ? null
        : ButtonWidget(
            enabled: true,
            type: ButtonType.secondary,
            onPressed: () {
              SubscriptionWidget(
                classes: widget.viewModel.event?.classes,
                onSubscribe: (id) {
                  widget.viewModel.subscribe(id);
                },
                onUnsubscribe: (id) {
                  widget.viewModel.unsubscribe(id);
                },
              );
            },
            label: "Registration",
          );
  }

  _hasRegistration() {
    return widget.viewModel.event != null
        ? widget.viewModel.event?.classes
            ?.map((classes) => classes?.drivers?.where((driver) {
                  classId = classes.id;
                  return driver?.driverId == Session.instance.getUser()?.id;
                }))
            .isNotEmpty
        : false;
  }
}
