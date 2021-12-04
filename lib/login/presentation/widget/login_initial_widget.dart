import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginInitialWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginInitialWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginInitialWidgetState createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget("Já tenho uma conta", ButtonType.normal, () {
                  widget.viewModel.flow = LoginFlow.login;
                }),
                const BoundWidget(BoundType.huge),
                ButtonWidget("Criar uma conta", ButtonType.normal, () {
                  widget.viewModel.flow = LoginFlow.signin;
                }),
              ],
            ),
          );
        }),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    return false;
  }
}
