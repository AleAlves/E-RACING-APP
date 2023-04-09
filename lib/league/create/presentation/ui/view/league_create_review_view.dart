import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../league_create_view_model.dart';
import '../../navigation/league_create_flow.dart';

class LeagueCreateReviewView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateReviewView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateReviewViewState createState() => _LeagueCreateReviewViewState();
}

class _LeagueCreateReviewViewState extends State<LeagueCreateReviewView>
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size16),
          leagueNameWidget(),
          const SpacingWidget(LayoutSize.size16),
          leagueDescriptionsWidget(),
        ],
      ),
    );
  }

  Widget leagueNameWidget() {
    return Row(
      children: [
        const TextWidget(text: "Name:", style: Style.subtitle),
        const SpacingWidget(LayoutSize.size16),
        TextWidget(text: widget.viewModel.name, style: Style.subtitle)
      ],
    );
  }

  Widget leagueDescriptionsWidget() {
    return Row(
      children: [
        const TextWidget(text: "Description:", style: Style.subtitle),
        const SpacingWidget(LayoutSize.size16),
        TextWidget(text: widget.viewModel.description, style: Style.subtitle)
      ],
    );
  }

  Widget statusMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
              text: widget.viewModel.status?.message ?? '', style: Style.title),
          const SpacingWidget(LayoutSize.size48),
          Icon(
            widget.viewModel.status?.error == true
                ? Icons.cancel
                : Icons.check_circle,
            size: 64,
            color: widget.viewModel.status?.error == true
                ? Colors.red
                : Colors.green,
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.create();
      },
      label: widget.viewModel.status?.action ?? 'Create League',
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(LeagueCreateNavigator.socialMedia);
    return false;
  }
}
