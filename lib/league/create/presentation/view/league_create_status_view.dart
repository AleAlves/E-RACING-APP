import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../../LeagueRouter.dart';
import '../league_create_view_model.dart';

class LeagueCreateStatusView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateStatusView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateStatusViewState createState() => _LeagueCreateStatusViewState();
}

class _LeagueCreateStatusViewState extends State<LeagueCreateStatusView>
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: statusMessage(),
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
        Modular.to.pushNamed(LeagueRouter.list);
      },
      label: widget.viewModel.status?.action,
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
