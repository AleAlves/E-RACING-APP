import 'package:e_racing_app/core/ui/component/ui/default_error_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/cupertino.dart';

import 'loading_ripple.dart';

class ViewStateWidget extends StatelessWidget{

  final  Widget content;
  final ViewState state;

  const ViewStateWidget(this.content, this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   switch (state) {
     case ViewState.ready:
       return content;
     case ViewState.loading:
       return const LoadingRipple();
     case ViewState.error:
     default:
       return const DefaulErrorWidget();
   }
  }
}