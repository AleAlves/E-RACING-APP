import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/ui/component/ui/text_widget.dart';
import '../../../login_router.dart';
import '../login_sign_in_view_model.dart';

class LoginSignInView extends StatefulWidget {
  final LoginSignInViewModel viewModel;

  const LoginSignInView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSignInViewState createState() => _LoginSignInViewState();
}

class _LoginSignInViewState extends State<LoginSignInView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    widget.viewModel.getPublicKey();
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
      body: content(),
      bottom: loginWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  observers() {
    _disposers
        .add(reaction((_) => widget.viewModel.user, (UserModel? userModel) {
      _emailController.text = widget.viewModel.user?.profile?.email ?? "";
      _passwordController.text = widget.viewModel.user?.auth?.password ?? "";
    }));
  }

  @override
  Widget content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size128),
          Form(child: loginForm(), key: _formKey),
        ],
      ),
    );
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Lottie.asset('assets/checkred-flag.json',
              width: MediaQuery.of(context).size.width / 3, repeat: false),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
              enabled: true,
              label: 'Email',
              icon: Icons.mail,
              controller: _emailController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty == true ||
                    !value.contains("@")) {
                  return 'valid email needed';
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
                }
                return null;
              },
              inputType: InputType.password),
          const SpacingWidget(LayoutSize.size8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  TextWidget(
                      text: widget.viewModel.errorMessage, style: Style.error),
                ],
              ),
            ),
          ),
          const SpacingWidget(LayoutSize.size8),
          ButtonWidget(
            enabled: true,
            type: ButtonType.link,
            onPressed: () {
              Modular.to.pushNamed(LoginRouter.recovery);
            },
            label: "Forgot password",
          ),
          ButtonWidget(
            enabled: true,
            type: ButtonType.link,
            onPressed: () {
              Modular.to.pushNamed(LoginRouter.signUp);
            },
            label: "Create account",
          ),
        ],
      ),
    );
  }

  Widget loginWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel
              .login(_emailController.text, _passwordController.text);
        }
      },
      label: "Login",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pushNamed(LoginRouter.onboard);
    return false;
  }
}
