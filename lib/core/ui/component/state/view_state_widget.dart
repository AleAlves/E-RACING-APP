import 'package:e_racing_app/core/ui/component/ui/default_error_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'loading_ripple.dart';

class ViewStateWidget extends StatelessWidget {
  final Widget content;
  final ViewState state;
  final WillPopCallback onBackPressed;

  const ViewStateWidget(this.content, this.state, this.onBackPressed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.ready:
        return _scope(content);
      case ViewState.loading:
        return const LoadingRipple();
      case ViewState.error:
      default:
        return const DefaulErrorWidget();
    }
  }

  Widget _scope(Widget content) {
    return WillPopScope(
        child: content,
        onWillPop: onBackPressed);
  }
}
