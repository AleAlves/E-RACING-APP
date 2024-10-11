import 'package:e_racing_app/core/ui/component/ui/scroll_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';

import '../ui/default_error_widget.dart';
import '../ui/float_action_button_widget.dart';
import 'loading_ripple.dart';

class ViewStateWidget extends StatelessWidget {
  final Widget body;
  final Widget? bottom;
  final ViewState state;
  final AlignmentGeometry alignment;
  final FloatActionButtonWidget? floatAction;
  final WillPopCallback onBackPressed;

  const ViewStateWidget(
      {required this.body,
      required this.state,
      required this.onBackPressed,
      this.bottom,
      this.alignment = Alignment.topCenter,
      this.floatAction,
      super.key});

  @override
  Widget build(BuildContext context) => _content(context) ?? Container();

  Widget? _content(BuildContext context) {
    switch (state) {
      case ViewState.ready:
        return _scaffold(context, body);
      case ViewState.loading:
        return const LoadingRipple();
      case ViewState.failure:
      default:
        return const DefaultErrorWidget();
    }
  }

  Widget _scaffold(BuildContext context, Widget content) {
    return Scaffold(
        body: _scope(context, content),
        bottomNavigationBar: _bottomSheetWidget(context),
        floatingActionButton: floatAction);
  }

  Widget? _bottomSheetWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: bottom,
    );
  }

  Widget _scope(BuildContext context, Widget content) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Align(alignment: alignment, child: ScrollWidget(content)));
  }
}
