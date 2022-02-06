import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventCreateTeamWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventCreateTeamWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateTeamWidgetState createState() => _EventCreateTeamWidgetState();
}

class _EventCreateTeamWidgetState extends State<EventCreateTeamWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _codeController = TextEditingController();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: getCode(),
          key: _formKey,
        ),
      ],
    );
  }

  @override
  observers() {}

  Widget getCode() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          InputTextWidget(
              label: 'Email',
              icon: Icons.vpn_key,
              controller: _mailController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'Email needed';
                }
                return null;
              }),
          const BoundWidget(BoundType.size48),
          InputTextWidget(
              label: 'Email',
              icon: Icons.vpn_key,
              controller: _mailController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'Email needed';
                }
                return null;
              }),
          const BoundWidget(BoundType.size16),
          InputTextWidget(
              label: 'Code',
              icon: Icons.security,
              controller: _codeController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'code needed';
                }
                return null;
              }),
          const BoundWidget(BoundType.size48),
          ButtonWidget(
            enabled: true,
            type: ButtonType.normal,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {

              }
            },
            label: "Generate reset code",
          )
        ],
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlows.list);
    return false;
  }
}
