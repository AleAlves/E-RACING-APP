import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateTagsView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateTagsView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateTagsViewState createState() => _EventCreateTagsViewState();
}

class _EventCreateTagsViewState extends State<EventCreateTagsView>
    implements BaseSateWidget {
  List<String?> tags = [];

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
      scrollable: false,
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleWidget(),
          const SpacingWidget(LayoutSize.size48),
          tagWidget()
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget titleWidget() {
    return const TextWidget(
        text: "Pick some tags for the event", style: Style.subtitle);
  }

  Widget tagWidget() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected = tags.contains(item?.id);
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
                                ? tags.remove(item?.id)
                                : tags.add(item?.id);
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
        widget.viewModel.setEventTags(tags);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.classes);
    return false;
  }
}
