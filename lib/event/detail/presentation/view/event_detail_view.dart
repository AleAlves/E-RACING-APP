import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
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

  const EventDetailView(this.viewModel, {super.key});

  @override
  EventDetailViewState createState() => EventDetailViewState();
}

class EventDetailViewState extends State<EventDetailView>
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
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size16),
        info(),
        standings(),
        races(),
        registrationWidget(),
        const SpacingWidget(LayoutSize.size96),
      ],
    );
  }

  Widget info() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BannerWidget(media: widget.viewModel.eventBanner),
          ),
          const SpacingWidget(LayoutSize.size16),
          title(),
          const SpacingWidget(LayoutSize.size16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: eventStatusWidget(widget.viewModel.event?.state),
          ),
          const SpacingWidget(LayoutSize.size8),
          ButtonWidget(
              enabled: true,
              type: ButtonType.info,
              label: "Event details",
              onPressed: () {
                widget.viewModel.onRoute(EventDetailRouter.info);
              }),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
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
    return isEventHost(widget.viewModel.event) ? adminOption() : null;
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
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: EventRaceCollection(
          onRaceCardPressed: (id) {
            widget.viewModel.goToRace(id);
          },
          races: widget.viewModel.event?.races),
    );
  }

  Widget standings() {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: SimpleStandingsWidget(
          standings: widget.viewModel.standings,
          onRaceCardPressed: (id) {},
          onFullStandingsPressed: () {
            widget.viewModel.onRoute(EventDetailRouter.standings);
          },
        ));
  }

  Widget registrationWidget() {
    var driver = widget.viewModel.event?.classes
        ?.firstWhere(
          (clazz) =>
      clazz?.drivers?.any(
            (driver) =>
        driver?.driverId == Session.instance
            .getUser()
            ?.id,
      ) ??
          false,
      orElse: () => null,
    )
        ?.drivers
        ?.firstWhere(
          (driver) =>
      driver?.driverId == Session.instance
          .getUser()
          ?.id,
      orElse: () => null,
    );
    return _hasRegistration()
        ? Padding(
      padding: EdgeInsets.all(8),
      child: CardWidget(
        arrowed: true,
        padding: EdgeInsets.zero,
        onPressed: () {
          confirmationDialogExt(
            context: context,
            issueMessage:
            "Do you want to cancel your registration? all your data will be lost.",
            consentMessage: "Yes, I do",
            onPositive: () {
              widget.viewModel.unsubscribe(classId);
            },
          );
        },
        ready: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  IconWidget(icon: Icons.account_box, size: 32),
                  SpacingWidget(LayoutSize.size16),
                  TextWidget(
                    text: "Driver credentials",
                    style: Style.title,
                    align: TextAlign.start,
                  ),
                ],),
                Row(
                  children: [
                    IconWidget(
                      icon: Icons.monetization_on,
                      color: driver?.isFeePaid == true ? Colors.green : Colors
                          .amberAccent,
                    ),
                    SpacingWidget(LayoutSize.size8),
                    IconWidget(
                      icon: driver?.isAccepted == true ? Icons
                          .check_circle_rounded : Icons.cancel_rounded,
                      color: driver?.isAccepted == true ? Colors.green : Colors
                          .red,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    )
        : Container();
  }

  Widget? doRegisterButton() {
    return widget.viewModel.event?.joinable == false || _hasRegistration()
        ? null
        : ButtonWidget(
      enabled: true,
      type: ButtonType.secondary,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) =>
              SubscriptionWidget(
                classes: widget.viewModel.event?.classes,
                onSubscribe: (id) {
                  widget.viewModel.subscribe(id);
                },
                onUnsubscribe: (id) {
                  widget.viewModel.unsubscribe(id);
                },
              ),
        );
      },
      label: "Register",
    );
  }

  bool _hasRegistration() {
    return widget.viewModel.event?.classes?.any((clazz) {
      var driver = clazz?.drivers?.firstWhere(
            (driver) =>
        driver?.driverId == Session.instance
            .getUser()
            ?.id,
        orElse: () => null,
      );
      if (driver != null) {
        return true;
      }
      return false;
    }) ??
        false;
  }
}
