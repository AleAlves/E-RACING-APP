import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../app_view_model.dart';

class AppEnviromentView extends StatefulWidget {
  final AppViewModel viewModel;

  const AppEnviromentView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _AppEnviromentViewState createState() => _AppEnviromentViewState();
}

class _AppEnviromentViewState extends State<AppEnviromentView>
    implements BaseSateWidget {
  final String devLocal = "http://192.168.0.19:8084/";
  final String prod = "https://e-racing-api.azurewebsites.net/";

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        alignment: Alignment.center,
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    String? group = "";

    return CardWidget(
      ready: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(text: "Enviroments", style: Style.title),
          const SpacingWidget(LayoutSize.size48),
          ListTile(
            title: const Text('Local'),
            leading: Radio<String>(
              groupValue: group,
              value: devLocal,
              onChanged: (String? value) {
                setState(() {
                  widget.viewModel.setUrl(value);
                });
              },
            ),
          ),
          const SpacingWidget(LayoutSize.size16),
          ListTile(
            title: const Text('Azure'),
            leading: Radio<String>(
              groupValue: group,
              value: prod,
              onChanged: (String? value) {
                setState(() {
                  widget.viewModel.setUrl(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
