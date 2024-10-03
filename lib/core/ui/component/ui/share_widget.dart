import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/share_model.dart';

class ShareWidget extends StatefulWidget {
  final ShareModel? model;
  final Color? color;
  final Color? background;
  final double? size;
  final VoidCallback? onPressed;

  const ShareWidget(
      {required this.model,
      this.color,
      this.background,
      this.size,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  _ShareWidgetState createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<ShareWidget> {
  String? _linkMessage;
  bool? onSharing = false;

  final String link = 'https://eracingapp.page.link';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      widget.model == null ? Container() : content();

  Widget content() {
    return ButtonWidget(
        icon: Icons.share,
        enabled: true,
        iconRadius: widget.size ?? 20.0,
        iconColor: widget.color,
        color: widget.background,
        type: widget.background == null
            ? ButtonType.iconShapeless
            : ButtonType.icon,
        onPressed: () {
          if (onSharing == false) {
            setState(() {
              onSharing = true;
            });
            _createDynamicLink(true, () {
              Share.share("$_linkMessage");
              setState(() {
                onSharing = false;
              });
            });
          }
        });
  }

  Future<void> _createDynamicLink(bool short, Function onCreated) async {
    setState(() {
      _linkMessage = "";
      onCreated.call();
    });
  }
}
