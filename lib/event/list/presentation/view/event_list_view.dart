import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/event/list/presentation/event_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ui/component/ui/text_widget.dart';

class EventListView extends StatefulWidget {
  final EventListViewModel viewModel;

  const EventListView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventListViewState createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getTags();
    widget.viewModel.fetchEvents();
    widget.viewModel.title = "Events";
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
      floatAction: FloatActionButtonWidget(
        icon: Icons.add,
        title: "Create new",
        onPressed: () {
          Modular.to.pushNamed(EventRouter.create);
        },
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  @override
  Widget content() {
    return widget.viewModel.events?.isEmpty == true
        ? emptyBoxWidget()
        : eventsList();
  }

  Widget eventsList() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size8),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.viewModel.events?.length,
            itemBuilder: (context, index) {
              return EventCardWidget(
                tags: widget.viewModel.tags,
                icon: getIcon(widget.viewModel.events?[index]?.type),
                color: getColor(widget.viewModel.events?[index]?.type),
                event: widget.viewModel.events?[index],
                onPressed: () {
                  Session.instance
                      .setEventId(widget.viewModel.events?[index]?.id);
                  Modular.to.pushNamed(EventRouter.detail);
                },
              );
            },
          ),
        ),
        const SpacingWidget(LayoutSize.size8),
      ],
    );
  }

  Widget emptyBoxWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size256),
          const TextWidget(
            text: "Not events found",
            style: Style.title,
          ),
          const SpacingWidget(LayoutSize.size24),
          Icon(
            Icons.playlist_remove_outlined,
            size: 56,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
