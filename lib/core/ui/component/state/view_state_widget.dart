import 'package:e_racing_app/core/ui/component/ui/default_error_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scroll_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/float_action_button_widget.dart';
import 'loading_ripple.dart';

class ViewStateWidget extends StatelessWidget {
  final Widget content;
  final ViewState state;
  final FloatActionButtonWidget? floatAction;
  final WillPopCallback onBackPressed;
  final bool scrollable;

  const ViewStateWidget(
      {required this.content,
      required this.state,
      required this.onBackPressed,
      this.scrollable = true,
      this.floatAction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _content(context);

  Widget _content(BuildContext context) {
    switch (state) {
      case ViewState.ready:
        return _scaffold(context, content);
      case ViewState.loading:
        return const LoadingRipple();
      case ViewState.error:
      default:
        return const DefaulErrorWidget();
    }
  }

  Widget _scaffold(BuildContext context, Widget content) {
    return Scaffold(
      body: _scope(context, content),
      floatingActionButton: floatAction,
    );
  }

  Widget _scope(BuildContext context, Widget content) {
    if (scrollable) {
      return WillPopScope(
          child: ScrollWidget(content), onWillPop: onBackPressed);
    }
    return WillPopScope(child: content, onWillPop: onBackPressed);
  }
}
