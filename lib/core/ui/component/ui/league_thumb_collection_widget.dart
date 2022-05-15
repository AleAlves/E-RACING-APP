import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/picture_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeagueThumbCollectionWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final List<LeagueModel?>? leagues;

  const LeagueThumbCollectionWidget(
      {required this.onPressed, required this.leagues, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _LeagueThumbCollectionWidgetState createState() =>
      _LeagueThumbCollectionWidgetState();
}

class _LeagueThumbCollectionWidgetState
    extends State<LeagueThumbCollectionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.leagues?.isEmpty == true
        ? SizedBox(
            child: const LoadingShimmer(height: 150),
            width: MediaQuery.of(context).size.width - 16,
          )
        : leaguesThumb(widget.leagues ?? []);
  }

  Widget leaguesThumb(List<LeagueModel?> leagues) {
    return Expanded(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              return CardWidget(
                ready: true,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    PictureWidget(
                      padding: 0.0,
                      width: 150,
                      height: 150,
                      image: leagues[index]?.emblem,
                    ),
                    const SpacingWidget(LayoutSize.size16),
                    Expanded(
                      child: SizedBox(
                          width: 150,
                          child: TextWidget(
                              text: leagues[index]?.name, style: Style.note)),
                    ),
                  ],
                ),
                onPressed: () {
                  Session.instance.setLeagueId(leagues[index]?.id);
                  widget.onPressed?.call();
                },
              );
            }),
      ),
    );
  }
}
