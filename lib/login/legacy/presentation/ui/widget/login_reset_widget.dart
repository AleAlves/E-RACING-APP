import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/login_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../login_view_model.dart';

class LoginResetWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginResetWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginResetWidgetState createState() => _LoginResetWidgetState();
}

class _LoginResetWidgetState extends State<LoginResetWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _mailController = TextEditingController();
  final _codeController = TextEditingController();
  final List<ReactionDisposer> _disposers = [];
  late String password = "";

  @override
  void initState() {
    _mailController.text = '';
    _passwordController.text = '';
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
  observers() {
    _disposers
        .add(reaction((_) => widget.viewModel.user, (UserModel? userModel) {
      _mailController.text = widget.viewModel.user?.profile?.email ?? '';
    }));
  }

  @override
  Widget content() {
    return Form(
      child: resetForm(),
      key: _formKey,
    );
  }

  Widget resetForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size128),
          const TextWidget(
              text: "Use the code we've sent you by email",
              style: Style.paragraph),
          const SpacingWidget(LayoutSize.size48),
          InputTextWidget(
              enabled: true,
              label: 'Validation code',
              icon: Icons.security,
              controller: _codeController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'Validation code needed';
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
            label: 'Confirm password',
            icon: Icons.vpn_key,
            controller: _passwordConfirmationController,
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
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: _passwordConfirmationController.text.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel.reset(_mailController.text, _passwordController.text,
              _codeController.text);
        }
      },
      label: 'Create new password',
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
