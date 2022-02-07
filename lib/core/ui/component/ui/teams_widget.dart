import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'spacing_widget.dart';
import 'button_widget.dart';

class TeamsWidget extends StatefulWidget {
  final List<TeamModel?>? teams;
  final int? maxCrew;
  final Function(String?) onLeave;
  final Function(String?) onJoin;
  final Function(String?) onDelete;

  const TeamsWidget(
      {required this.teams,
      required this.maxCrew,
      required this.onLeave,
      required this.onJoin,
      required this.onDelete,
      Key? key})
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
                    return CardWidget(
                      ready: true,
                      onPressed: () {
                        details(team);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.groups_outlined,
                          ),
                          const SpacingWidget(LayoutSize.size16),
                          TextWidget(
                              text: "${team?.name}", style: Style.description),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.sports_motorsports),
                                ),
                                TextWidget(
                                    text:
                                        "(${team?.crew?.length.toString()}/${widget.maxCrew.toString()})",
                                    style: Style.description),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    );
                  })
                  .toList()
                  .cast<Widget>(),
            ),
            const SpacingWidget(LayoutSize.size16),
          ],
        ),
      );
    }
  }

  details(TeamModel? team) {
    var alreadyInTeam = team?.crew
            ?.where((element) => element == Session.instance.getUser()?.id)
            .isNotEmpty ??
        false;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48.0),
        child: SizedBox(
          child: Wrap(
            children: [
              Column(
                children: [
                  const SpacingWidget(LayoutSize.size24),
                  Row(
                    children: [
                      TextWidget(text: team?.name, style: Style.title),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size24),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 5.0,
                    children: team!.crew!.map((crew) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.groups_outlined,
                          ),
                          const SpacingWidget(LayoutSize.size16),
                          TextWidget(text: crew, style: Style.description),
                          const Icon(Icons.chevron_right)
                        ],
                      );
                    })
                        .toList()
                        .cast<Widget>(),
                  ),
                  const SpacingWidget(LayoutSize.size48),
                  alreadyInTeam
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              label: "Leave",
                              type: ButtonType.icon,
                              icon: Icons.exit_to_app,
                              onPressed: () {
                                widget.onLeave(team.id);
                              },
                              enabled: true,
                            ),
                            const SpacingWidget(LayoutSize.size16),
                            ButtonWidget(
                              label: "Delete",
                              type: ButtonType.icon,
                              icon: Icons.delete,
                              onPressed: () {
                                widget.onDelete(team.id);
                              },
                              enabled: true,
                            ),
                          ],
                        )
                      : ButtonWidget(
                          label: "Join",
                          type: ButtonType.icon,
                          icon: Icons.person_add,
                          onPressed: () {
                            widget.onJoin(team.id);
                          },
                          enabled: true,
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
