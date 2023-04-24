import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../league_create_view_model.dart';
import '../navigation/league_create_flow.dart';

class LeagueCreateTagsView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateTagsView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateTagsViewState createState() => _LeagueCreateTagsViewState();
}

class _LeagueCreateTagsViewState extends State<LeagueCreateTagsView>
    implements BaseSateWidget {
  List<String?> tags = [];
  String buttonLabel = "Skip";

  @override
  void initState() {
    observers();
    widget.viewModel.fetchTags();
    tags = widget.viewModel.leagueTags?.toList() ?? [];
    super.initState();
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
          guideLines(),
          const SpacingWidget(LayoutSize.size48),
          tagPicker()
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget guideLines() {
    return const TextWidget(
        text:
            "Pick some tags, this will help the drivers to understand the bias of this league",
        style: Style.subtitle);
  }

  Widget tagPicker() {
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
                            widget.viewModel.setTags(tags);
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
        widget.viewModel.onNavigate(LeagueCreateNavigator.socialMedia);
      },
      label: widget.viewModel.leagueTags?.isEmpty == true ? "Skip" : "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(LeagueCreateNavigator.banner);
    return false;
  }
}
