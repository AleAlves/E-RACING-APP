import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../detail/presentation/league_detail_view_model.dart';
import '../../detail/presentation/navigation/league_detail_navigation.dart';

class LeagueDeleteWidget extends StatefulWidget {
  final LeagueDetailViewModel viewModel;

  const LeagueDeleteWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueDeleteWidgetState createState() => _LeagueDeleteWidgetState();
}

class _LeagueDeleteWidgetState extends State<LeagueDeleteWidget>
    implements BaseSateWidget {
  bool validForm = false;
  final _formKey = GlobalKey<FormState>();
  final _safetyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _safetyController.text = "";
    widget.viewModel.state = ViewState.ready;
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: _form(),
      key: _formKey,
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(LeagueDetailNavigationSet.main);
    return false;
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(text: "Excluding League", style: Style.title),
            const SpacingWidget(LayoutSize.size48),
            const TextWidget(
                text: "safety verification: 2+2?", style: Style.subtitle),
            const SpacingWidget(LayoutSize.size48),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
              child: InputTextWidget(
                enabled: true,
                label: "Answer",
                icon: Icons.title,
                controller: _safetyController,
                validator: (value) {
                  if (value == null || value.isEmpty == true || value != "4") {
                    return 'Wrong answer';
                  }
                  if (value == "5") {
                    return 'Did you read 1984? nice...wrong answer though';
                  }
                  return null;
                },
                onChange: (value) {
                  if (value.isNotEmpty || value == "4") {
                    setState(() {
                      validForm = true;
                    });
                  } else if (value.isEmpty) {
                    setState(() {
                      validForm = false;
                    });
                  }
                },
                inputType: InputType.number,
              ),
            ),
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: _formKey.currentState?.validate() == true,
                type: ButtonType.primary,
                onPressed: () {
                  widget.viewModel.delete();
                },
                label: "delete")
          ],
        ),
      ),
    );
  }
}
