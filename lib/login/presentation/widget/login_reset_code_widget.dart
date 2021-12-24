import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

class LoginResetCodeWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginResetCodeWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginResetCodeWidgetState createState() => _LoginResetCodeWidgetState();
}

class _LoginResetCodeWidgetState extends State<LoginResetCodeWidget> {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void initState() {
    _mailController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: getCode(),
              key: _formKey,
            ),
            Observer(builder: (_) {
              _mailController.text =
                  widget.viewModel.user?.profile?.email ?? '';
              return Container();
            })
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget getCode() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextFormWidget('Email', Icons.vpn_key, _mailController, (value) {
            if (value == null || value.isEmpty == true) {
              return 'Email needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          TextFormWidget('Code', Icons.security, _codeController, (value) {
            if (value == null || value.isEmpty == true) {
              return 'code needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          ButtonWidget(
            ButtonType.normal,
            () {
              if (_formKey.currentState?.validate() == true) {
                widget.viewModel.forgot(_mailController.text);
              }
            },
            label: "Generate reset code",
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
