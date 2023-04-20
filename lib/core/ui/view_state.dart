import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'component/state/view_state_widget.dart';

enum ViewState { ready, loading, error, status }

abstract class BaseScreen {
  Widget navigate();
}

abstract class BaseSateWidget {
  Observer mainObserver();

  ViewStateWidget viewState();

  Widget content();

  observers();

  Future<bool> onBackPressed();
}
