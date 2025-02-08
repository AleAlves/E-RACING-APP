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

class LeagueEventFeeView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const LeagueEventFeeView(this.viewModel, {super.key});

  @override
  LeagueEventFeeViewState createState() => LeagueEventFeeViewState();
}

class LeagueEventFeeViewState extends State<LeagueEventFeeView>
    implements BaseSateWidget {
  var isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _keyController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
    _valueController.text = widget.viewModel.paymentModel?.value ?? "";
    _keyController.text = widget.viewModel.paymentModel?.key ?? "";
    _notesController.text = widget.viewModel.paymentModel?.notes ?? "";
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
          key: _formKey,
          child: Column(
            children: [
              paymentValueForm(),
              paymentKeyForm(),
              paymentNotesForm()
            ],
          ),
        ),
      ],
    );
  }

  @override
  observers() {
    _valueController.addListener(() {
      final String text = _valueController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(
        text: "Fee",
        style: Style.title,
        align: TextAlign.start,
      ),
    );
  }

  Widget paymentValueForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
          enabled: true,
          label: 'Value',
          icon: Icons.person,
          inputType: InputType.number,
          controller: _valueController,
          validator: (value) {
            if (value == null || value.isEmpty == true) {
              return 'cant be empty';
            }
            return null;
          }),
    );
  }

  Widget paymentKeyForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
          enabled: true,
          label: 'Key',
          icon: Icons.person,
          inputType: InputType.text,
          controller: _keyController,
          validator: (value) {
            if (value == null || value.isEmpty == true) {
              return 'cant be empty';
            }
            return null;
          }),
    );
  }

  Widget paymentNotesForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
          enabled: true,
          label: 'Notes',
          icon: Icons.person,
          inputType: InputType.text,
          controller: _notesController,
          validator: (value) {
            if (value == null || value.isEmpty == true) {
              return 'cant be empty';
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
        widget.viewModel.setEventPayment(
            _valueController.text, _keyController.text, _notesController.text);
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
