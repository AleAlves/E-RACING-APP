import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../home/domain/model/community_card_vo.dart';
import 'banner_widget.dart';

class LeagueCardSmallWidget extends StatefulWidget {
  final List<CommunityCardVO?>? leagues;
  final Function(String?) onPressed;

  const LeagueCardSmallWidget(
      {required this.leagues, required this.onPressed, Key? key})
      : super(key: key);

  @override
  _LeagueCardSmallWidgetState createState() => _LeagueCardSmallWidgetState();
}

class _LeagueCardSmallWidgetState extends State<LeagueCardSmallWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.leagues?.length,
      itemBuilder: (context, index) {
        return cardWidget(index);
      },
    );
  }

  Widget cardWidget(int index) {
    return Column(
      children: [
        CardWidget(
          padding: EdgeInsets.zero,
          onPressed: () {
            widget.onPressed.call(widget.leagues?[index]?.leagueId);
          },
          child: header(index),
          ready: widget.leagues?.isNotEmpty == true,
        ),
      ],
    );
  }

  Widget header(int index) {
    return Column(
      children: [
        BannerWidget(
          media: widget.leagues?[index]?.media,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: titleWidget(index),
        ),
      ],
    );
  }

  Widget titleWidget(int index) {
    return Row(
      children: [
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                text: widget.leagues?[index]?.name,
                style: Style.subtitle,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
