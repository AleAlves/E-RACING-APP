import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
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
        content: content(),
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
          const TextWidget(
              text: "Use the code we've sent you by email",
              style: Style.description),
          const BoundWidget(BoundType.medium),
          InputTextWidget('Validation code', Icons.security, _codeController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Validation code needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          InputTextWidget(
            'Password',
            Icons.vpn_key,
            _passwordController,
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
            },
            inputType: InputType.password,
          ),
          const BoundWidget(BoundType.medium),
          InputTextWidget(
            'Confirm password',
            Icons.vpn_key,
            _passwordController,
            (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              } else if (value != password) {
                return 'Password not the same';
              }
              return null;
            },
            inputType: InputType.password,
          ),
          const BoundWidget(BoundType.xl),
          ButtonWidget(
            enabled: true,
            type: ButtonType.normal,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                widget.viewModel.reset(_mailController.text,
                    _passwordController.text, _codeController.text);
              }
            },
            label: 'Create password',
          )
        ],
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
