import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/text/text_widget.dart';
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
              "Use o token enviado para seu email concluir a alteração da senha", Style.description),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _codeController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Validation code needed';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Validation code',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.security,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: _passwordVisible,
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
            decoration: const InputDecoration(
              labelText: 'Senha',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.vpn_key,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: '',
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              } else if (value != password) {
                return 'Password not the same';
              }
              return null;
            },
            obscureText: _passwordVisible,
            decoration: const InputDecoration(
              labelText: 'Confirmar senha',
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
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  widget.viewModel.reset(_mailController.text,
                      _passwordController.text, _codeController.text);
                }
              },
              child: const Text("Criar nova senha"),
            ),
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
