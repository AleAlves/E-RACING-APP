import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:mobx/mobx.dart';

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
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    _mailController.text = '';
    observers();
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
    _disposers.add(reaction((_) => widget.viewModel.user, (UserModel? userModel) {
      _mailController.text = widget.viewModel.user?.profile?.email ?? '';
    }));
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: getCode(),
          key: _formKey,
        ),
      ],
    );
  }

  Widget getCode() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          InputTextWidget('Email', Icons.vpn_key, _mailController, (value) {
            if (value == null || value.isEmpty == true) {
              return 'Email needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          InputTextWidget('Code', Icons.security, _codeController, (value) {
            if (value == null || value.isEmpty == true) {
              return 'code needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.xl),
          ButtonWidget(
            enabled: true,
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

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
