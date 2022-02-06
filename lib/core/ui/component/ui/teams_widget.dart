import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bound_widget.dart';

class TeamsWidget extends StatefulWidget {
  final List<TeamModel?>? teams;
  final int maxCrew;

  const TeamsWidget({required this.teams, required this.maxCrew, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _TeamsWidgetState createState() => _TeamsWidgetState();
}

class _TeamsWidgetState extends State<TeamsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.teams == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 5.0,
              children: widget.teams!
                  .map((team) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                  text: "${team?.name}:",
                                  style: Style.description),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                          Icons.sports_motorsports),
                                    ),
                                    TextWidget(
                                        text:
                                            "(${team?.crew?.length.toString()}/${widget.maxCrew.toString()})",
                                        style: Style.description),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const BoundWidget(BoundType.size16),
                        ],
                      ),
                    );
                  })
                  .toList()
                  .cast<Widget>(),
            ),
            const BoundWidget(BoundType.size16),
          ],
        ),
      );
    }
  }
}
