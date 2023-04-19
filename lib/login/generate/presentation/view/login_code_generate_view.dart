import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/country_picker_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../login_code_generate_view_model.dart';

class LoginCodeGenerateView extends StatefulWidget {
  final LoginCodeGenerateViewModel viewModel;

  const LoginCodeGenerateView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginCodeGenerateViewState createState() => _LoginCodeGenerateViewState();
}

class _LoginCodeGenerateViewState extends State<LoginCodeGenerateView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  late String password = "";
  late String? country = "BR";

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
        body: content(),
        bottom: buttonWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: PasswordResetForm(),
      key: _formKey,
    );
  }

  Widget PasswordResetForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(text: "Create Account", style: Style.paragraph),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
              enabled: true,
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
              enabled: true,
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
              enabled: true,
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
            enabled: true,
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
            enabled: true,
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
          const SpacingWidget(LayoutSize.size16),
          CountryPickerWidget(
            onCountrySelected: (code) {
              country = code;
            },
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          // widget.viewModel.PasswordReset(_nameController.text, _surnameController.text,
          //     _mailController.text, _passwordController.text, country ?? '');
        }
      },
      label: "Create account",
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    // widget.viewModel.flow = LoginWidgetFlow.loginOnboarding;
    return false;
  }
}
