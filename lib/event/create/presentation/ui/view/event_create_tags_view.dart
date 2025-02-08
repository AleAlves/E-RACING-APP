import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';

class EventCreateTagsView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateTagsView(this.viewModel, {super.key});

  @override
  EventCreateTagsViewState createState() => EventCreateTagsViewState();
}

class EventCreateTagsViewState extends State<EventCreateTagsView>
    implements BaseSateWidget {
  @override
  void initState() {
    observers();
    super.initState();
    widget.viewModel.fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: button(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size24),
        title(),
        const SpacingWidget(LayoutSize.size16),
        tagWidget()
      ],
    );
  }

  @override
  observers() {}

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(
        text: "Tags",
        style: Style.title,
        align: TextAlign.start,
      ),
    );
  }

  Widget tagWidget() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.all(8),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected =
                        widget.viewModel.eventTags.contains(item?.id);
                    return ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: selected
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: selected ? const Text('-') : const Text('+'),
                        ),
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          setState(() {
                            selected
                                ? widget.viewModel.eventTags.remove(item?.id)
                                : widget.viewModel.eventTags.add(item?.id);
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
          );
  }

  Widget button() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.onFinishEventTags();
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    return false;
  }
}
