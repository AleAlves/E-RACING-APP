import 'package:e_racing_app/core/model/shortcut_model.dart';
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
  final List<LeagueModel?>? leagues;

  const LeagueThumbCollectionWidget({required this.leagues, Key? key})
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
        ? Container()
        : leaguesThumb(widget.leagues ?? []);
  }

  Widget leaguesThumb(List<LeagueModel?> leagues) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: leagues
          .map((league) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PictureWidget(
                width: 100,
                height: 100,
                image: league?.emblem,
              ),
            );
          })
          .toList()
          .cast<Widget>(),
    );
  }
}
