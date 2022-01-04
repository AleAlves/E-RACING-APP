import 'package:flutter/cupertino.dart';

enum ViewState { ready, loading, error }


abstract class BaseView {
  abstract final String tag;

  Widget navigate();
}
