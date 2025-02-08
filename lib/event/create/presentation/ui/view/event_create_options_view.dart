import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventOptionsView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventOptionsView(this.viewModel, {super.key});

  @override
  EventOptionsViewState createState() => EventOptionsViewState();
}

class EventOptionsViewState extends State<EventOptionsView>
    implements BaseSateWidget {

  @override
  void initState() {
    observers();
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
  observers() {}

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
        titleWidget(),
        const SpacingWidget(LayoutSize.size16),
        optionsWidget()
      ],
    );
  }

  Widget titleWidget() {
    return
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: const TextWidget(text: "Options", style: Style.title, align: TextAlign.start,),
      );
  }

  Widget optionsWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.viewModel.eventAllowTeams,
                onChanged: (bool? value) {
                  setState(() {
                    widget.viewModel.setToggleEventAllowTeamsOption(value);
                  });
                },
              ),
              const TextWidget(
                  text: "Allow racing teams", style: Style.paragraph)
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: widget.viewModel.eventAllowMembersOnly,
                onChanged: (bool? value) {
                  setState(() {
                    widget.viewModel.setToggleEventAllowMembersOnly(value);
                  });
                },
              ),
              const TextWidget(text: "For registered members only", style: Style.paragraph)
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: widget.viewModel.hasFee,
                onChanged: (bool? value) {
                  setState(() {
                    widget.viewModel.setToggleEventHasFee(value);
                  });
                },
              ),
              const TextWidget(
                  text: "Has registration fee", style: Style.paragraph)
            ],
          )
        ],
      ),
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.setOptions();
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
