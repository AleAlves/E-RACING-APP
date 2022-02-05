import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scoring_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/settings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/subscription_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventDetailWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventDetailWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget>
    implements BaseSateWidget {
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    widget.viewModel.getEvent();
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
        content: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlows.list);
    return false;
  }

  @override
  Widget content() {
    return Stack(
      children: [
        Column(
          children: [
            const BoundWidget(BoundType.sm),
            banner(),
            const BoundWidget(BoundType.sm),
            title(),
            const BoundWidget(BoundType.sm),
            status(),
            const BoundWidget(BoundType.sm),
            information(),
            const BoundWidget(BoundType.sm),
            subscription(),
          ],
        ),
        FloatActionButtonWidget<EventFlows>(
          flow: EventFlows.create,
          icon: Icons.build,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
    );
  }

  Widget banner() {
    return BannerWidget(
      media: widget.viewModel.media,
    );
  }

  Widget title() {
    return CardWidget(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextWidget(
              text: widget.viewModel.event?.title, style: Style.title)),
      ready: true,
    );
  }

  Widget status() {
    return EventProgressWidget(
      state: widget.viewModel.event?.state,
    );
  }

  Widget information() {
    return ExpandedWidget(
        header: Row(
          children: const [
            TextWidget(
              text: "Informations",
              style: Style.subtitle,
              align: TextAlign.left,
            ),
          ],
        ),
        body: [
          rules(),
          const BoundWidget(BoundType.sm),
          scoring(),
          const BoundWidget(BoundType.sm),
          settings(),
          const BoundWidget(BoundType.sm),
          teams()
        ],
        ready: true);
  }

  Widget rules() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(Icons.gavel),
          BoundWidget(BoundType.medium),
          TextWidget(
            text: "Rules",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        const BoundWidget(BoundType.medium),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
            text: widget.viewModel.event?.rules ?? '',
            style: Style.description,
            align: TextAlign.justify,
          ),
        ),
        const BoundWidget(BoundType.medium),
      ],
    );
  }

  Widget scoring() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(
            Icons.format_list_numbered_outlined,
          ),
          BoundWidget(BoundType.medium),
          TextWidget(
            text: "Score system",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        ScoringWidget(
          scoring: widget.viewModel.event?.scoring,
          editing: false,
          onScore: (wow) {},
        ),
        const BoundWidget(BoundType.medium),
      ],
    );
  }

  Widget settings() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(
            Icons.settings,
          ),
          BoundWidget(BoundType.medium),
          TextWidget(
            text: "Settings",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        const BoundWidget(BoundType.medium),
        SettingsWidget(settings: widget.viewModel.event?.settings),
        const BoundWidget(BoundType.medium),
      ],
    );
  }

  Widget teams() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(
            Icons.supervised_user_circle,
          ),
          BoundWidget(BoundType.medium),
          TextWidget(
            text: "Teams",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        const BoundWidget(BoundType.medium),
        ScoringWidget(
          scoring: widget.viewModel.event?.scoring,
          editing: false,
          onScore: (wow) {},
        ),
        const BoundWidget(BoundType.medium),
      ],
    );
  }

  Widget subscription() {
    return SubscriptionWidget(
      classes: widget.viewModel.event?.classes,
      onSubscribe: (id) {
        widget.viewModel.subscribe(id);
      },
      onUnsubscribe: (id) {
        widget.viewModel.unsubscribe(id);
      },
    );
  }
}
