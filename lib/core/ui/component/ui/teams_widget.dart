import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'icon_widget.dart';
import 'spacing_widget.dart';

class TeamsWidget extends StatefulWidget {
  final bool isHost;
  final List<TeamModel?>? teams;
  final List<UserModel?>? users;
  final List<ClassesModel?>? classes;
  final int? maxCrew;
  final Function(String?) onLeave;
  final Function(String?) onJoin;
  final Function(String?) onDelete;

  const TeamsWidget(
      {required this.isHost,
      required this.teams,
      required this.users,
      required this.classes,
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
                      arrowed: true,
                      onPressed: () {
                        details(team);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: IconWidget(
                                      icon: Icons.sports_motorsports),
                                ),
                                TextWidget(
                                    text:
                                        "(${team?.crew?.length.toString()}/${widget.maxCrew.toString()})",
                                    style: Style.paragraph),
                              ],
                            ),
                          ),
                          TextWidget(
                              text: "${team?.name}", style: Style.paragraph),
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
                    children: team!.crew!
                        .map((crew) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const IconWidget(
                                  icon: Icons.sports_motorsports,
                                ),
                                const SpacingWidget(LayoutSize.size16),
                                TextWidget(
                                    text: getName(crew),
                                    style: Style.paragraph),
                              ],
                            ),
                          );
                        })
                        .toList()
                        .cast<Widget>(),
                  ),
                  const SpacingWidget(LayoutSize.size48),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyInTeam
                          ? ButtonWidget(
                              label: "Leave",
                              type: ButtonType.icon,
                              icon: Icons.exit_to_app,
                              onPressed: () {
                                widget.onLeave(team.id);
                              },
                              enabled: true,
                            )
                          : Container(),
                      !alreadyInTeam && isSubscriber(widget.classes)
                          ? ButtonWidget(
                              label: "Join",
                              type: ButtonType.icon,
                              icon: Icons.person_add,
                              onPressed: () {
                                widget.onJoin(team.id);
                              },
                              enabled: true,
                            )
                          : Container(),
                      const SpacingWidget(LayoutSize.size16),
                      widget.isHost || alreadyInTeam
                          ? ButtonWidget(
                              label: "Delete",
                              type: ButtonType.icon,
                              icon: Icons.delete,
                              onPressed: () {
                                widget.onDelete(team.id);
                              },
                              enabled: true,
                            )
                          : Container(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getName(String? id) {
    var user =
        widget.users?.firstWhere((element) => element?.id == id)?.profile;
    return "${user?.firstName} ${user?.surName}";
  }
}
