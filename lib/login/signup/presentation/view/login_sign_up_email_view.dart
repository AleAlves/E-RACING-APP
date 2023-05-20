import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/text_widget.dart';
import '../login_sign_up_view_model.dart';
import '../router/login_sign_up_navigation.dart';

class LoginSignUpMailView extends StatefulWidget {
  final LoginSignUpViewModel viewModel;

  const LoginSignUpMailView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSignUpMailViewState createState() => _LoginSignUpMailViewState();
}

class _LoginSignUpMailViewState extends State<LoginSignUpMailView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();

  @override
  void initState() {
    _mailController.text = '';
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
        bottom: buttonWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: signinForm(),
      key: _formKey,
    );
  }

  Widget signinForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(text: "Now your email", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size16),
          const TextWidget(
            text:
                "Make sure to provide a valid one. Don't worry we'll never spam you but we need to valdiate the account",
            style: Style.caption,
            align: TextAlign.start,
          ),
          const SpacingWidget(LayoutSize.size8),
          const TextWidget(
            text: "This information won't be public in this platform",
            style: Style.caption,
            align: TextAlign.start,
          ),
          const SpacingWidget(LayoutSize.size32),
          InputTextWidget(
              enabled: true,
              label: 'Email',
              icon: Icons.mail,
              controller: _mailController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty == true ||
                    !value.contains("@")) {
                  return 'valid email needed';
                }
                return null;
              }),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setEmail(_mailController.text);
      },
      label: "Next",
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.name);
    return false;
  }
}
