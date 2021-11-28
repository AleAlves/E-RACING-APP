import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/text/text_widget.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../login_view_model.dart';


class LoginOtpQRWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginOtpQRWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginOtpQRWidgetState createState() => _LoginOtpQRWidgetState();
}

class _LoginOtpQRWidgetState extends State<LoginOtpQRWidget> {
  var isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget("Scaneie o QR", Style.description),
            const SizedBox(height: 24,),
            QrImage(
              data: widget.viewModel.otpQR ?? '',
              version: QrVersions.auto,
              size: 200.0,
            ),
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginFlow.initial;
    return false;
  }
}
