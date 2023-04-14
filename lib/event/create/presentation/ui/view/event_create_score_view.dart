import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/scoring_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateScoreView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateScoreView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateScoreViewState createState() => _EventCreateScoreViewState();
}

class _EventCreateScoreViewState extends State<EventCreateScoreView>
    implements BaseSateWidget {
  List<int?> scoreSchema = [];

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
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: buttonWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            const SpacingWidget(LayoutSize.size32),
            titleWidget(),
            const SpacingWidget(LayoutSize.size32),
            scoringWidget(),
          ],
        ),
      ),
    );
  }

  @override
  observers() {}

  Widget titleWidget() {
    return const TextWidget(
        text: "You can change the score system of your event",
        style: Style.subtitle);
  }

  Widget scoringWidget() {
    return ScoringWidget(
      editing: true,
      onScore: (scoring) {
        scoreSchema = scoring;
      },
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setEventScore(scoreSchema);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.rules);
    return false;
  }
}