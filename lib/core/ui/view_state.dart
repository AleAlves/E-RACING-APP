import 'package:flutter/cupertino.dart';

enum ViewState { ready, loading, error }

abstract class BaseView {
  Widget navigate();
}
