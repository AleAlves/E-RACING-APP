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
  Widget build(BuildContext context) {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: _onBackPressed);
  }

  Widget content() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
                widget.viewModel.status?.message ?? '', Style.description),
            const BoundWidget(BoundType.medium),
            ButtonWidget(
              ButtonType.normal,
              () {
                widget.viewModel.flow =
                    widget.viewModel.status?.next ?? LoginWidgetFlow.init;
              },
              label: widget.viewModel.status?.action ?? '',
            )
          ],
        ),
      );
    });
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
