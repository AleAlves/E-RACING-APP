import 'package:flutter/cupertino.dart';

enum ViewState { ready, loading, error }

abstract class BaseScreen {
  Widget navigate();
}

abstract class BaseSateWidget {
  Widget content();
}
