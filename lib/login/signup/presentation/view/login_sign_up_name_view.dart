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

class LoginSignUpNameView extends StatefulWidget {
  final LoginSignUpViewModel viewModel;

  const LoginSignUpNameView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSignUpNameViewState createState() => _LoginSignUpNameViewState();
}

class _LoginSignUpNameViewState extends State<LoginSignUpNameView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
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
        bottom: buttonWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  observers() {
    _nameController.text = widget.viewModel.name ?? '';
    _surnameController.text = widget.viewModel.surname ?? '';
    _nameController.addListener(() {
      setState(() {
        _runValidations();
      });
    });
    _surnameController.addListener(() {
      setState(() {
        _runValidations();
      });
    });
  }

  _runValidations() {
    isValid =
        _nameController.text.isNotEmpty && _surnameController.text.isNotEmpty;
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
          const TextWidget(
              text: "Lets start with your name", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size32),
          InputTextWidget(
              enabled: true,
              label: 'Name',
              icon: Icons.person,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'valid name needed';
                }
                return null;
              }),
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(text: "and your Surname", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size32),
          InputTextWidget(
              enabled: true,
              label: 'Surname',
              icon: Icons.person,
              controller: _surnameController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'valid surName needed';
                }
                return null;
              }),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: isValid,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel
            .setNames(_nameController.text, _surnameController.text);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.terms);
    return false;
  }
}
