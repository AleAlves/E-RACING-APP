import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StatusView extends StatefulWidget {
  final BaseViewModel viewModel;

  const StatusView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _StatusViewState createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> implements BaseSateWidget {
  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

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
      child: Column(
        children: [const SpacingWidget(LayoutSize.size128), statusMessage()],
      ),
    );
  }

  Widget statusMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
              text: widget.viewModel.status?.message ?? '', style: Style.title),
          const SpacingWidget(LayoutSize.size48),
          Icon(
            widget.viewModel.status?.error == true
                ? Icons.cancel
                : Icons.check_circle,
            size: 64,
            color: widget.viewModel.status?.error == true
                ? Colors.red
                : Colors.green,
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        Modular.to.pushNamed(widget.viewModel.status?.next);
      },
      label: widget.viewModel.status?.action ?? '',
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
