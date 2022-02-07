import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../../login_view_model.dart';

class LoginSigninWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginSigninWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSigninWidgetState createState() => _LoginSigninWidgetState();
}

class _LoginSigninWidgetState extends State<LoginSigninWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  late String password = "";

  @override
  void initState() {
    _nameController.text = '';
    _mailController.text = '';
    _passwordController.text = '';
    _surnameController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: signinForm(),
      key: _formKey,
    );
  }

  Widget signinForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(text: "Create Account", style: Style.description),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
              label: 'Name',
              icon: Icons.person,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'valid name needed';
                }
                return null;
              }),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
              label: 'Surname',
              icon: Icons.person,
              controller: _surnameController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'valid surname needed';
                }
                return null;
              }),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
              label: 'Email',
              icon: Icons.mail,
              controller: _mailController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty == true ||
                    !value.contains("@")) {
                  return 'valid email needed';
                }
                return null;
              }),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            label: 'Password',
            icon: Icons.vpn_key,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              }
              if (value.length < 8) {
                return 'Password too short';
              } else {
                password = value;
              }
              return null;
            },
            inputType: InputType.password,
          ),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            label: 'Confirm password',
            icon: Icons.vpn_key,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              } else if (value != password) {
                return 'Password not the same';
              }
              return null;
            },
            inputType: InputType.password,
          ),
          const SpacingWidget(LayoutSize.size48),
          ButtonWidget(
            enabled: true,
            type: ButtonType.normal,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                widget.viewModel.signin(
                    _nameController.text,
                    _surnameController.text,
                    _mailController.text,
                    _passwordController.text);
              }
            },
            label: "Create account",
          )
        ],
      ),
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
