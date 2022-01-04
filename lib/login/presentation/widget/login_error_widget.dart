import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/presentation/login_view_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';

class LoginErrorWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginErrorWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginErrorWidgetState createState() => _LoginErrorWidgetState();
}

class _LoginErrorWidgetState extends State<LoginErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextWidget("Tente Novamente", Style.subtitle),
                const BoundWidget(BoundType.medium),
                Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: ERcaingApp.color,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh),
                        color: Colors.white,
                        onPressed: widget.viewModel.retry,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = widget.viewModel.status?.next ?? LoginWidgetFlow.init;
    return false;
  }
}
