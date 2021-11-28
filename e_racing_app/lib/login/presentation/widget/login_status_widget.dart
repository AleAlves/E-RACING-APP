import 'package:flutter/material.dart';
import 'package:e_racing_app/core/ui/component/text/text_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';


class LoginStatusWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginStatusWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginStatusWidgetState createState() => _LoginStatusWidgetState();
}

class _LoginStatusWidgetState extends State<LoginStatusWidget> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content(),
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(widget.viewModel.status?.message ?? '',  Style.description),
          const SizedBox(height: 16,),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 2,
            child: ElevatedButton(
              onPressed: () {
                widget.viewModel.flow = widget.viewModel.status?.next ?? LoginFlow.initial;
              },
              child: Text(widget.viewModel.status?.action ?? ''),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginFlow.initial;
    return false;
  }
}
