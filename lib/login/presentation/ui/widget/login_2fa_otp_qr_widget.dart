import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../login_view_model.dart';
import '../login_flow.dart';

class LoginOtpQRWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginOtpQRWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginOtpQRWidgetState createState() => _LoginOtpQRWidgetState();
}

class _LoginOtpQRWidgetState extends State<LoginOtpQRWidget>
    implements BaseSateWidget {
  var isSwitched = false;

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
      content: content(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextWidget(text: "Scaneie o QR", style: Style.description),
        const BoundWidget(BoundType.size8),
        QrImage(
          data: widget.viewModel.otpQR ?? '',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ],
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
