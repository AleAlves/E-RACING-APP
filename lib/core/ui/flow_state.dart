import 'package:flutter/cupertino.dart';

class FlowState<T> {
  final List<FlowView> flows;

  FlowState(this.flows);
}

class FlowView {
  final String tag;
  final Widget widget;

  FlowView({required this.tag, required this.widget});
}