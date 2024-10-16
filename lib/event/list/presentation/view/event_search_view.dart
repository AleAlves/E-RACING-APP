import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/event/list/presentation/event_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ui/component/ui/tag_collection_widget.dart';
import '../../../../core/ui/component/ui/text_widget.dart';

class EventSearchView extends StatefulWidget {
  final EventListViewModel viewModel;

  const EventSearchView(this.viewModel, {Key? key}) : super(key: key);

  @override
  EventSearchViewState createState() => EventSearchViewState();
}

class EventSearchViewState extends State<EventSearchView>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
    widget.viewModel.title = "Events";
    widget.viewModel.searchEvents();
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
        icon: Icons.filter_alt,
        title: "Search tags",
        onPressed: () {
          searchBottomSheet();
        },
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
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
        tagsWidget(),
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
                color: getColor(widget.viewModel.events?[index]?.type, context),
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

  Widget tagsWidget() {
    return widget.viewModel.searchTags?.isEmpty == true
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SpacingWidget(LayoutSize.size8),
                TagCollectionWidget(
                  tagIds: widget.viewModel.searchTags,
                  tags: widget.viewModel.tags,
                  singleLined: true,
                ),
              ],
            ),
          );
  }

  searchBottomSheet() {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Observer(builder: (context) {
                  return Wrap(
                    children: [
                      tagWidget(myState),
                      const SpacingWidget(LayoutSize.size32),
                      ButtonWidget(
                          enabled: true,
                          label: "Search",
                          type: ButtonType.primary,
                          onPressed: () {
                            widget.viewModel.searchEvents();
                            Navigator.of(context).pop();
                          }),
                      const SpacingWidget(LayoutSize.size16),
                    ],
                  );
                }),
              );
            }));
  }

  Widget tagWidget(StateSetter myState) {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected =
                        widget.viewModel.searchTags?.contains(item?.id) ??
                            false;
                    return ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: selected
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: selected ? const Text('-') : const Text('+'),
                        ),
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          myState(() {
                            selected
                                ? widget.viewModel.searchTags?.remove(item?.id)
                                : widget.viewModel.searchTags
                                    ?.add(item?.id ?? '');
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
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
            text: "No events found",
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
