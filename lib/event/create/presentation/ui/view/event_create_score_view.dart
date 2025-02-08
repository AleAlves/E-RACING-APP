import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/scoring_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateScoreView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateScoreView(this.viewModel, {super.key});

  @override
  EventCreateScoreViewState createState() => EventCreateScoreViewState();
}

class EventCreateScoreViewState extends State<EventCreateScoreView>
    implements BaseSateWidget {
  final _scoreController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
    if (widget.viewModel.eventScore.isEmpty) {
      widget.viewModel.eventScore.addAll([25, 18, 15, 12, 10, 8, 6, 4, 2, 1]);
    }
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
      alignment: Alignment.topLeft,
      body: content(),
      bottom: buttonWidget(),
      floatAction: FloatActionButtonWidget(
        icon: Icons.add,
        title: "New position",
        onPressed: () {
          createScoreBottomSheet();
        },
      ),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size24),
        title(),
        const SpacingWidget(LayoutSize.size48),
        scoringWidget(),
      ],
    );
  }

  @override
  observers() {}

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(text: "Score System", style: Style.title),
    );
  }

  Widget scoringWidget() {
    return Center(child: ScoringWidget(editing: true, scoring: widget.viewModel.eventScore),);
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: widget.viewModel.eventScore.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.onFinishScore();
      },
      label: "Next",
    );
  }

  void createScoreBottomSheet() {
    _scoreController.clear();
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, modelState) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SpacingWidget(LayoutSize.size16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        TextWidget(
                            text: "Points worthy",
                            style: Style.paragraph),
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size48),
                    InputTextWidget(
                        enabled: true,
                        label: "Score",
                        controller: _scoreController,
                        inputType: InputType.number,
                        validator: (value) {
                          if (value == null || double.tryParse(value) == null) {
                            return "invalid score value";
                          }
                        }),
                    const SpacingWidget(LayoutSize.size48),
                    ButtonWidget(
                        enabled: _scoreController.text.isNotEmpty,
                        label: "Create",
                        type: ButtonType.primary,
                        onPressed: () async {
                          setState(() {
                            widget.viewModel.eventScore
                                .add(int.parse(_scoreController.text));
                            Navigator.of(context).pop();
                          });
                        }),
                    const SpacingWidget(LayoutSize.size16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    return false;
  }
}
