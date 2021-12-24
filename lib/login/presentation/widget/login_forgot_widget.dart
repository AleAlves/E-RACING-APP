import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginForgotWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginForgotWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginForgotWidgetState createState() => _LoginForgotWidgetState();
}

class _LoginForgotWidgetState extends State<LoginForgotWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(child: forgotForm(), key: _formKey),
            Observer(builder: (_) {
              _emailController.text =
                  widget.viewModel.user?.profile?.email ?? "";
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget forgotForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const TextWidget("Recuperação de senha", Style.description),
          const BoundWidget(BoundType.big),
          TextFormWidget("Email", Icons.mail, _emailController, (value) {
            if (value == null ||
                value.isEmpty == true ||
                !value.contains("@")) {
              return 'valid email needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.big),
          ButtonWidget(ButtonType.normal, () {
            if (_formKey.currentState?.validate() == true) {
              widget.viewModel.forgot(_emailController.text);
            }
          }, label: "Recuperar",),
          const BoundWidget(BoundType.big),
          ButtonWidget(ButtonType.borderless, () {
            widget.viewModel.flow = LoginFlow.reset;
          }, label: "Já tenho o código",),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginFlow.initial;
    return false;
  }
}
