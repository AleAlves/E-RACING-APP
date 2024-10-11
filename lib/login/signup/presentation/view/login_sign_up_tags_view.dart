import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/text_widget.dart';
import '../login_sign_up_view_model.dart';
import '../router/login_sign_up_navigation.dart';

class LoginSignUpTagsView extends StatefulWidget {
  final LoginSignUpViewModel viewModel;

  const LoginSignUpTagsView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSignUpTagsViewState createState() => _LoginSignUpTagsViewState();
}

class _LoginSignUpTagsViewState extends State<LoginSignUpTagsView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.viewModel.getTags();
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
        children: [
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(
              text: "Pick some topics of your like", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size48),
          const SpacingWidget(LayoutSize.size48),
          tagPickerWidget()
        ],
      ),
    );
  }

  Widget tagPickerWidget() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              spacing: 4,
              alignment: WrapAlignment.spaceBetween,
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected =
                        widget.viewModel.userTags?.contains(item?.id) ?? false;
                    return ActionChip(
                        backgroundColor: selected
                            ? Theme.of(context).colorScheme.secondary
                            : null,
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          setState(() {
                            selected
                                ? widget.viewModel.userTags?.remove(item?.id)
                                : widget.viewModel.userTags
                                    ?.add(item?.id ?? '');
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
          );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setTags();
      },
      label: widget.viewModel.userTags?.isEmpty == true ? "Skip" : "Next",
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.nationality);
    return false;
  }
}
