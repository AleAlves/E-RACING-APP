import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../login_router.dart';
import '../login_onboard_view_model.dart';

class LoginOnboardView extends StatefulWidget {
  final LoginOnboardViewModel viewModel;

  const LoginOnboardView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginOnboardViewState createState() => _LoginOnboardViewState();
}

class _LoginOnboardViewState extends State<LoginOnboardView>
    implements BaseSateWidget {
  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  void initState() {
    super.initState();
  }

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpacingWidget(LayoutSize.size128),
            const TextWidget(text: "Welcome driver", style: Style.title),
            const SpacingWidget(LayoutSize.size32),
            const TextWidget(
                text:
                    "This a platform to help connect driver in fair competitions",
                style: Style.paragraph),
            const SpacingWidget(LayoutSize.size128),
            const TextWidget(
              text: "Aready a member",
              style: Style.paragraph,
            ),
            const SpacingWidget(LayoutSize.size16),
            ButtonWidget(
              enabled: true,
              icon: Icons.people,
              type: ButtonType.iconButton,
              onPressed: () {
                widget.viewModel.saveTutorialExhibition(LoginRouter.signIn);
              },
              label: "Login",
            )
          ],
        ),
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.saveTutorialExhibition(LoginRouter.signUp);
      },
      label: "Create an account",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
