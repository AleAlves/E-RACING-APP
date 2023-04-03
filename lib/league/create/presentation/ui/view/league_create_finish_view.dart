import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../league_create_view_model.dart';

class LeagueCreateFinishView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateFinishView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateFinishViewState createState() => _LeagueCreateFinishViewState();
}

class _LeagueCreateFinishViewState extends State<LeagueCreateFinishView>
    implements BaseSateWidget {
  @override
  void initState() {
    observers();
    super.initState();
    widget.viewModel.create();
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
        children: [statusMessage()],
      ),
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
        Modular.to.pop();
      },
      label: widget.viewModel.status?.action ?? '',
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
