import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';

class EventCreateNameView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateNameView(this.viewModel, {super.key});

  @override
  EventCreateNameViewState createState() => EventCreateNameViewState();
}

class EventCreateNameViewState extends State<EventCreateNameView>
    implements BaseSateWidget {
  var isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    observers();
    _nameController.text = widget.viewModel.eventName.toString();
    super.initState();
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
  observers() {
    _nameController.addListener(() {
      final String text = _nameController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: button(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size24),
        titleWidget(),
        const SpacingWidget(LayoutSize.size16),
        Form(
          key: _formKey,
          child: nameWidget(),
        )
      ],
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(text: "Event name", style: Style.title),
    );
  }

  Widget nameWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
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
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: isValid,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.setEventName(_nameController.text);
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
