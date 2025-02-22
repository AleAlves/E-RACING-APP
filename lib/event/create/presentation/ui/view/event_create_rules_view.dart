import 'package:e_racing_app/event/create/presentation/navigation/event_create_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';

class LeagueEventRulesView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const LeagueEventRulesView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueEventRulesViewState createState() => _LeagueEventRulesViewState();
}

class _LeagueEventRulesViewState extends State<LeagueEventRulesView>
    implements BaseSateWidget {
  var isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
    _descriptionController.text = widget.viewModel.eventRules ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: button(),
      onBackPressed: onBackPressed,
      state: ViewState.ready,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size24),
        title(),
        const SpacingWidget(LayoutSize.size48),
        Form(
          child: leagueNameForm(),
          key: _formKey,
        ),
      ],
    );
  }

  @override
  observers() {
    _descriptionController.addListener(() {
      final String text = _descriptionController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(
        text: "Rules",
        style: Style.title,
        align: TextAlign.start,
      ),
    );
  }

  Widget leagueNameForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
          enabled: true,
          label: 'Rules',
          icon: Icons.person,
          inputType: InputType.multilines,
          controller: _descriptionController,
          validator: (value) {
            if (value == null || value.isEmpty == true) {
              return 'type something';
            }
            return null;
          }),
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: isValid,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.setEventRules(_descriptionController.text);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    return false;
  }
}
