import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'component/state/view_state_widget.dart';

enum ViewState { ready, loading, failure, status }

abstract class BaseScreen {
  Observer mainObserver();

  Widget scaffold();

  Widget navigate();
}

abstract class BaseSateWidget {
  Observer mainObserver();

  ViewStateWidget viewState();

  Widget content();

  observers();

  Future<bool> onBackPressed();
}
