import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateClassesView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateClassesView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateClassesViewState createState() => _EventCreateClassesViewState();
}

class _EventCreateClassesViewState extends State<EventCreateClassesView>
    implements BaseSateWidget {
  var isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
    _nameController.addListener(observers);
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
      scrollable: false,
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          guideLines(),
          const SpacingWidget(LayoutSize.size48),
          Form(
            child: leagueNameForm(),
            key: _formKey,
          ),
        ],
      ),
    );
  }

  @override
  observers() {
    setState(() {
      isValid = _formKey.currentState?.validate() == true;
    });
  }

  Widget guideLines() {
    return const TextWidget(
        text: "What is the name of the event?", style: Style.subtitle);
  }

  Widget leagueNameForm() {
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
        widget.viewModel.setEventName(_nameController.text);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.terms);
    return false;
  }
}
