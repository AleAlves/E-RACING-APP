import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/text/text_widget.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginSigninWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginSigninWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSigninWidgetState createState() => _LoginSigninWidgetState();
}

class _LoginSigninWidgetState extends State<LoginSigninWidget> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  late bool _passwordVisible;
  late String password = "";

  @override
  void initState() {
    _passwordVisible = true;
    _nameController.text = '';
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
              child: signinForm(),
              key: _formKey,
            ),
            Observer(builder: (_) {
              return Container();
            })
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget signinForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const TextWidget("Criar conta", Style.description),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'valid name needed';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.person,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _mailController,
            validator: (value) {
              if (value == null || value.isEmpty == true || !value.contains("@")) {
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
                  widget.viewModel.signin(
                      _nameController.text,
                      _mailController.text,
                      _passwordController.text);
                }
              },
              child: const Text("Cadastrar"),
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
