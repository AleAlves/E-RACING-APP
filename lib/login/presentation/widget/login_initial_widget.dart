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
  int _quit = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.viewModel.flow = LoginFlow.login;
                    },
                    child: const Text("Já tenho uma conta"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.viewModel.flow = LoginFlow.signin;
                    },
                    child: const Text("Cria uma conta"),
                  ),
                ),
              ],
            ),
          );
        }),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    if (_quit == 0) {
      _toast();
      return false;
    } else if (_quit == 2) {
      return true;
    }
    _quit++;
    return false;
  }

  void _toast() {
    Fluttertoast.showToast(
        msg: "Press againt to leave",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0);
  }
}
