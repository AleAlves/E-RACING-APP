import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../login/legacy/domain/model/user_model.dart';
import '../../../model/classes_model.dart';

class EntryStandingsWidget extends StatefulWidget {
  final List<ClassesModel?>? entries;
  final List<UserModel?>? users;
  final bool hasFee;
  final Function(String) onRaceCardPressed;
  final Function onFullStandingsPressed;

  const EntryStandingsWidget(
      {super.key,
      required this.entries,
      required this.users,
      required this.hasFee,
      required this.onRaceCardPressed,
      required this.onFullStandingsPressed});

  @override
  EntryStandingsWidgetState createState() => EntryStandingsWidgetState();
}

class EntryStandingsWidgetState extends State<EntryStandingsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => CardWidget(
        ready: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: raceList(context),
        ),
      );

  Widget raceList(BuildContext context) {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SpacingWidget(LayoutSize.size8),
            TextWidget(
              text: "Entries",
              style: Style.subtitle,
              align: TextAlign.start,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size16),
        Column(
          children: classesList(context),
        ),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  List<Widget> classesList(BuildContext context) {
    return widget.entries?.map((clazz) {
          String? entry = "";
          bool? isPaid;
          bool? isAccepted;
          clazz?.drivers?.map((driver) {
            var name = widget.users
                ?.firstWhere(
                    (user) => clazz.drivers?.first?.driverId == user?.id)
                ?.profile;
            entry = "${name?.firstName} ${name?.surName}";
            isPaid = driver?.isFeePaid;
            isAccepted = driver?.isAccepted;
          }).toList();
          return Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: entry ?? "",
                  style: Style.caption,
                  align: TextAlign.start,
                ),
                Row(
                  children: [
                    IconWidget(
                      icon: Icons.monetization_on,
                      color: isPaid == true ? Colors.green : Colors.amberAccent,
                    ),
                    SpacingWidget(LayoutSize.size8),
                    IconWidget(
                      icon: Icons.check_circle_rounded,
                      color: isAccepted == true ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList() ??
        [Container()];
  }
}
