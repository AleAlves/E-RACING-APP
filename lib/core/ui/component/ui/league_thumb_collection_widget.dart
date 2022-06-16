import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/picture_widget.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:flutter/material.dart';

class LeagueThumbCollectionWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final List<LeagueModel?>? leagues;

  const LeagueThumbCollectionWidget(
      {required this.onPressed, required this.leagues, Key? key})
      : super(key: key);

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
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  child: const LoadingShimmer(height: 150),
                  width: MediaQuery.of(context).size.width / 3 - 8,
                ),
                SizedBox(
                  child: const LoadingShimmer(height: 150),
                  width: MediaQuery.of(context).size.width / 3 - 8,
                ),
                SizedBox(
                  child: const LoadingShimmer(height: 150),
                  width: MediaQuery.of(context).size.width / 3 - 8,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: leagues(widget.leagues ?? []),
          );
  }

  Widget leagues(List<LeagueModel?> leagues) {
    return Wrap(
      children: leagues.isEmpty
          ? [Container()]
          : leagues
              .map((item) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 8,
                  child: CardWidget(
                    ready: true,
                    padding: EdgeInsets.zero,
                    child: PictureWidget(
                      padding: 0,
                      width: MediaQuery.of(context).size.width / 3,
                      height:  MediaQuery.of(context).size.width / 3,
                      image: item?.emblem,
                    ),
                    onPressed: () {
                      Session.instance.setLeagueId(item?.id);
                      widget.onPressed?.call();
                    },
                  ),
                );
              })
              .toList()
              .cast<Widget>(),
    );
  }
}
