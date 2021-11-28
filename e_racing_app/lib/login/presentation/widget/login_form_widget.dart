import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginFormWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    widget.viewModel.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(child: loginForm(), key: _formKey),
            Observer(builder: (_) {
              _emailController.text =
                  widget.viewModel.user?.profile?.email ?? "";
              _passwordController.text =
                  widget.viewModel.user?.auth?.password ?? "";
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
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
              labelText: 'Email',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.mail,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              }
              if (value.length < 8) {
                return 'Password too short';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Senha',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.vpn_key,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 2,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  widget.viewModel
                      .login(_emailController.text, _passwordController.text);
                }
              },
              child: const Text("Entrar"),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextButton(
            onPressed: () {
              widget.viewModel.flow = LoginFlow.resetCode;
            },
            child: const Text("Esqueci a senha"),
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
