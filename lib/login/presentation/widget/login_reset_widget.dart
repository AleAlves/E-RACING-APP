import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginResetWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginResetWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginResetWidgetState createState() => _LoginResetWidgetState();
}

class _LoginResetWidgetState extends State<LoginResetWidget> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _codeController = TextEditingController();
  late bool _passwordVisible;
  late String password = "";

  @override
  void initState() {
    _passwordVisible = true;
    _mailController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: resetForm(),
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

  Widget resetForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const TextWidget(
              "Use the code we've sent you by email",
              Style.description),
          const BoundWidget(BoundType.medium),
          TextFormWidget('Validation code', Icons.security, _codeController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Validation code needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          TextFormWidget('Password', Icons.vpn_key, _passwordController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Password needed';
            }
            if (value.length < 8) {
              return 'Password too short';
            } else {
              password = value;
            }
            return null;
          }, obscure: _passwordVisible),
          const BoundWidget(BoundType.medium),
          TextFormWidget('Confirm password', Icons.vpn_key, _passwordController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Password needed';
            } else if (value != password) {
              return 'Password not the same';
            }
            return null;
          }, obscure: _passwordVisible),
          const BoundWidget(BoundType.medium),
          ButtonWidget(ButtonType.normal, () {
            if (_formKey.currentState?.validate() == true) {
              widget.viewModel.reset(_mailController.text,
                  _passwordController.text, _codeController.text);
            }
          }, label: 'Create password',)
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginFlow.initial;
    return false;
  }
}
