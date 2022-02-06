import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../../login_view_model.dart';

class LoginStatusWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginStatusWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginStatusWidgetState createState() => _LoginStatusWidgetState();
}

class _LoginStatusWidgetState extends State<LoginStatusWidget>
    implements BaseSateWidget {
  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
            text: widget.viewModel.status?.message ?? '',
            style: Style.description),
        const BoundWidget(BoundType.size16),
        ButtonWidget(
          enabled: true,
          type: ButtonType.normal,
          onPressed: () {
            widget.viewModel.flow =
                widget.viewModel.status?.next ?? LoginWidgetFlow.init;
          },
          label: widget.viewModel.status?.action ?? '',
        )
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
