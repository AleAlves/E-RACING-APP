import 'package:e_racing_app/core/ui/component/ui/default_error_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scroll_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/cupertino.dart';

import 'loading_ripple.dart';

class ViewStateWidget extends StatelessWidget {
  final Widget content;
  final ViewState state;
  final WillPopCallback onBackPressed;
  final bool scrollable;

  const ViewStateWidget(
      {required this.content,
      required this.state,
      required this.onBackPressed,
      this.scrollable = false,
      Key? key})
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
    if(scrollable){
      return WillPopScope(child: ScrollWidget(content), onWillPop: onBackPressed);
    }
    return WillPopScope(child: content, onWillPop: onBackPressed);
  }
}
