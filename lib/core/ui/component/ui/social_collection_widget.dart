import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'button_widget.dart';
import 'card_widget.dart';

class SocialCollectionWidget extends StatefulWidget {
  final bool hide;
  final List<LinkModel?>? links;
  final List<SocialPlatformModel?>? socialPlatforms;

  const SocialCollectionWidget(
      {this.hide = false,
      required this.links,
      required this.socialPlatforms,
      Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _SocialCollectionWidgetState createState() => _SocialCollectionWidgetState();
}

class _SocialCollectionWidgetState extends State<SocialCollectionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.hide
        ? Container()
        : CardWidget(
            ready: widget.links != null,
            placeholderHeight: 100,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Wrap(
                    spacing: 10.0,
                    children: widget.links == null
                        ? [Container()]
                        : widget.links!
                            .map((item) {
                              return Column(
                                children: [
                                  ButtonWidget(
                                    enabled: true,
                                    type: ButtonType.icon,
                                    onPressed: () {},
                                    icon: _getIcon(item?.platformId),
                                    label: widget.socialPlatforms
                                            ?.firstWhere((element) =>
                                                element?.id == item?.platformId)
                                            ?.name ??
                                        '',
                                  ),
                                ],
                              );
                            })
                            .toList()
                            .cast<Widget>(),
                  ),
                ],
              ),
            ),
          );
  }

  IconData _getIcon(String? platformId) {
    var index = widget.socialPlatforms
        ?.firstWhere((element) => element?.id == platformId)
        ?.name
        .toLowerCase();
    switch (index) {
      case "whatsapp":
        return FontAwesomeIcons.whatsapp;
      case "discord":
        return FontAwesomeIcons.discord;
      case "telegram":
        return FontAwesomeIcons.telegram;
      case "instagram":
        return FontAwesomeIcons.instagram;
      case "facebook":
        return FontAwesomeIcons.facebook;
      case "youtube":
        return FontAwesomeIcons.youtube;
      case "twitch":
        return FontAwesomeIcons.twitch;
      case "site":
      case "blog":
      default:
        return FontAwesomeIcons.globe;
    }
  }
}
