import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/model/float_action_button_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../event_view_model.dart';

class CreateListWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const CreateListWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _CreateListWidgetState createState() => _CreateListWidgetState();
}

class _CreateListWidgetState extends State<CreateListWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }

  @override
  Widget content() {
    return Container();
  }
}
