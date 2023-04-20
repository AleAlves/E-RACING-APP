import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

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
        iconColor: widget.color ?? Theme.of(context).cardTheme.color,
        color: widget.background,
        type: widget.background == null
            ? ButtonType.iconBorderless
            : ButtonType.iconButton,
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
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: link,
      link: Uri.parse('$link?'
          'route=${widget.model?.route}&'
          'leagueId=${widget.model?.leagueId}&'
          'eventId=${widget.model?.eventId}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.br.e.e_racing_app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.invertase.testing',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: widget.model?.message, description: widget.model?.name),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      onCreated.call();
    });
  }
}
