import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../login_view_model.dart';

class LoginEnviromentWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginEnviromentWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginEnviromentWidgetState createState() => _LoginEnviromentWidgetState();
}

class _LoginEnviromentWidgetState extends State<LoginEnviromentWidget>
    implements BaseSateWidget {
  final String devLocal = "http://192.168.0.14:8084/";
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
        scrollable: false,
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    String? group = "";

    return Center(
      child: CardWidget(
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
                    Session.instance.setURL(value ?? '');
                    widget.viewModel.flow = LoginWidgetFlow.login;
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
                    Session.instance.setURL(value ?? '');
                    widget.viewModel.flow = LoginWidgetFlow.login;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
