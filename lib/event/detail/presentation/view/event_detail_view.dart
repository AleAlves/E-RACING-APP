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
import '../../../../core/tools/session.dart';
import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/event_step_progress_indicator_widget.dart';
import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../../core/ui/component/ui/share_widget.dart';
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
              child: banner(),
            ),
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: eventInfo(),
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

  Widget banner() {
    return CardWidget(
      padding: EdgeInsets.zero,
      ready: true,
      child: Column(
        children: [
          Stack(
            children: [
              BannerWidget(media: widget.viewModel.eventBanner),
              Positioned(
                top: 0,
                right: 0,
                child: ShareWidget(
                    size: 16.0,
                    background: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.onPrimary,
                    model: widget.viewModel.share),
              )
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
          title(),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
    );
  }

  Widget title() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextWidget(
              text: widget.viewModel.event?.title, style: Style.title),
        ),
      ],
    );
  }

  Widget eventInfo() {
    return CardWidget(
      arrowed: true,
      childLeft: Icon(
        Icons.info_outline,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      onPressed: () {
        widget.viewModel.onRoute(EventDetailRouter.info);
      },
      ready: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SpacingWidget(LayoutSize.size8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      text: "Event",
                      style: Style.subtitle,
                    ),
                    EventStepProgressIndicatorWidget(
                      state: widget.viewModel.event?.state,
                      orientation: StatusOrientation.horizontal,
                    ),
                    Container()
                  ],
                ),
                const SpacingWidget(LayoutSize.size8),
              ],
            ),
          ),
        ],
      ),
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
