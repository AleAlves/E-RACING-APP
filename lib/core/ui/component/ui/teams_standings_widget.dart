import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/event/data/event_teams_standings_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:flutter/material.dart';

import 'icon_widget.dart';

class TeamsStandingsWidget extends StatefulWidget {
  final EventTeamsStandingsModel? standings;

  const TeamsStandingsWidget(
      {Key? key,
      required this.standings})
      : super(key: key);

  @override
  _TeamsStandingsWidgetState createState() => _TeamsStandingsWidgetState();
}

class _TeamsStandingsWidgetState extends State<TeamsStandingsWidget> {
  var _index = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => raceList(context);

  Widget raceList(BuildContext context) {
    _index = 0;
    return CardWidget(
      ready: widget.standings != null,
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SpacingWidget(LayoutSize.size8),
              TextWidget(
                text: "Teams",
                style: Style.subtitle,
                align: TextAlign.start,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size16),
          Column(
            children: classesList(context),
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      ),
    );
  }

  List<Widget> classesList(BuildContext context) {
    return widget.standings?.summaries!.map((summary) {
          ++_index;
          return raceCard(context, summary, _index);
        }).toList() ??
        [Container()];
  }

  Widget raceCard(
      BuildContext context, TeamsStandingsModel? teamStanding, int position) {
    return CardWidget(
      ready: true,
      shapeLess: true,
      padding: EdgeInsets.zero,
      onPressed: (){
        showResume(teamStanding);
      },
      child: Container(
        color: Colors.black12,
        child: Column(
          children: [
            Row(
              children: [
                const SpacingWidget(LayoutSize.size8),
                Row(
                  children: [
                    Container(
                      color: getPodiumColor(position).first,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: "$positionº",
                          style: Style.paragraph,
                          color: getPodiumColor(position).second,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpacingWidget(LayoutSize.size8),
                Expanded(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
                        child: TextWidget(
                          text:
                          "${teamStanding?.team?.name}",
                          style: Style.paragraph,
                          align: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: "${teamStanding?.points} pts",
                        style: Style.paragraph,
                        align: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const IconWidget(icon: Icons.chevron_right, borderless: false,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showResume(TeamsStandingsModel? teamStanding){
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return teamResume(teamStanding);
            }));
  }

  Widget teamResume(TeamsStandingsModel? teamStanding) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size16),
              Row(
                children: [
                  const SpacingWidget(LayoutSize.size32),
                  TextWidget(
                    text: "${teamStanding?.team?.name}",
                    style: Style.paragraph,
                  ),
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              Row(
                children: [
                  const SpacingWidget(LayoutSize.size32),
                  TextWidget(
                    text: "${teamStanding?.points} pts",
                    style: Style.paragraph,
                  ),
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              teamCrew(teamStanding?.users),
              const SpacingWidget(LayoutSize.size48),
            ],
          ),
        )
      ],
    );
  }

  Widget teamCrew(List<UserModel?>? users){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: users?.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpacingWidget(LayoutSize.size16),
            CountryCodePicker(
              onChanged: print,
              showCountryOnly: true,
              enabled: false,
              initialSelection: users?[index]?.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
            const SpacingWidget(LayoutSize.size16),
            const IconWidget(icon: Icons.sports_motorsports),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: "${users?[index]?.profile?.name} ${users?[index]?.profile?.surname}",
              style: Style.paragraph,
            ),
          ],
        );
      },
    );
  }
}
