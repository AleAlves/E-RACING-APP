import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
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
            child: Row(
              children: [
                Wrap(
                  spacing: 25.0,
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
                                    icon: _getSocialPlatform(item?.platformId)
                                        .first,
                                    buttonColor:
                                        _getSocialPlatform(item?.platformId)
                                            .second,
                                    label: widget.socialPlatforms
                                            ?.firstWhere((element) =>
                                                element?.id == item?.platformId)
                                            ?.name ??
                                        '',
                                    labelColor: Colors.white),
                              ],
                            );
                          })
                          .toList()
                          .cast<Widget>(),
                ),
              ],
            ),
          );
  }

  Pair<IconData, Color> _getSocialPlatform(String? platformId) {
    var index = widget.socialPlatforms
        ?.firstWhere((element) => element?.id == platformId)
        ?.name
        .toLowerCase();
    switch (index) {
      case "whatsapp":
        return Pair(FontAwesomeIcons.whatsapp, const Color(0xFF41D200));
      case "discord":
        return Pair(FontAwesomeIcons.discord, const Color(0xFF737EE7));
      case "telegram":
        return Pair(FontAwesomeIcons.telegram, const Color(0xFF41B2FF));
      case "instagram":
        return Pair(FontAwesomeIcons.instagram, const Color(0xFFD40081));
      case "facebook":
        return Pair(FontAwesomeIcons.facebook, const Color(0xFF262DFD));
      case "youtube":
        return Pair(FontAwesomeIcons.youtube, const Color(0xFFFF0000));
      case "twitch":
        return Pair(FontAwesomeIcons.twitch, const Color(0xFFD000FF));
      case "site":
      case "blog":
      default:
        return Pair(FontAwesomeIcons.blog, const Color(0xFFFDD300));
    }
  }
}
