import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';

class LoginErrorWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginErrorWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginErrorWidgetState createState() => _LoginErrorWidgetState();
}

class _LoginErrorWidgetState extends State<LoginErrorWidget>
    implements BaseSateWidget {
  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      content: content(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextWidget(text: "Tente Novamente", style: Style.subtitle),
        const SpacingWidget(LayoutSize.size16),
        Material(
          color: Colors.transparent,
          child: Center(
            child: Ink(
              decoration: const ShapeDecoration(
                color: ERcaingApp.color,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.refresh),
                color: Colors.white,
                onPressed: widget.viewModel.retry,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow =
        widget.viewModel.status?.next ?? LoginWidgetFlow.login;
    return false;
  }

  @override
  observers() {}
}
