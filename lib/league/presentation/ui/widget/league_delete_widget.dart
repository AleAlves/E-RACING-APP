import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../league_view_model.dart';
import '../league_flow.dart';

class LeagueDeleteWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

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
        content: content(),
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
    widget.viewModel.setFlow(LeagueFlow.detail);
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
            const BoundWidget(BoundType.xl),
            const TextWidget(
                text: "safety verification: 2+2?", style: Style.subtitle),
            const BoundWidget(BoundType.xl),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
              child: InputTextWidget(
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
            const BoundWidget(BoundType.xl),
            ButtonWidget(
                enabled: _formKey.currentState?.validate() == true,
                type: ButtonType.normal,
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
