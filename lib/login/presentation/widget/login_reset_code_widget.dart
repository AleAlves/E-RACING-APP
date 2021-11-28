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

class _LoginResetCodeWidgetState extends State<LoginResetCodeWidget> {
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
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: getCode(),
              key: _formKey,
            ),
            Observer(builder: (_) {
              _mailController.text = widget.viewModel.user?.profile?.email ?? '';
              return Container();
            })
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget getCode() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextFormField(
            controller: _mailController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Email needed';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Email',
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
            controller: _codeController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'code needed';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Code',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.security,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  widget.viewModel.forgot(_mailController.text);
                }
              },
              child: const Text("Receber código de validação"),
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
