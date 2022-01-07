import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return ViewStateWidget(
      content: content(),
      onBackPressed: _onBackPressed,
      state: widget.viewModel.state,
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow =
        widget.viewModel.status?.next ?? LoginWidgetFlow.init;
    return false;
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextWidget("Tente Novamente", Style.subtitle),
        const BoundWidget(BoundType.medium),
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
}
