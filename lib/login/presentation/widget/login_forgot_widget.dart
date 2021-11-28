import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/text/text_widget.dart';
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
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null ||
                  value.isEmpty == true ||
                  !value.contains("@")) {
                return 'valid email needed';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.mail,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  widget.viewModel.forgot(_emailController.text);
                }
              },
              child: const Text("Recuperar"),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextButton(
            onPressed: () {
              widget.viewModel.flow = LoginFlow.reset;
            },
            child: const Text("Já tenho o código"),
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
