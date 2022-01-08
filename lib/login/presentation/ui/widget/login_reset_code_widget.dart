import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
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

class _LoginResetCodeWidgetState extends State<LoginResetCodeWidget>
    implements BaseSateWidget {
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
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: _onBackPressed);
  }

  @override
  Widget content() {
    return Observer(builder: (_) {
      _mailController.text = widget.viewModel.user?.profile?.email ?? '';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: getCode(),
            key: _formKey,
          ),
        ],
      );
    });
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
            type: ButtonType.normal,
            onPressed: () {
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
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
