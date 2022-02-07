
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'spacing_widget.dart';
import 'button_widget.dart';

class MembershipActionWidget extends StatefulWidget {
  final LeagueModel? leagueModel;
  final bool isMember;
  final Function onStartMembership;
  final Function onStopMembership;

  const MembershipActionWidget(
      {required this.isMember,
      required this.leagueModel,
      required this.onStartMembership,
      required this.onStopMembership,
      Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _MembershipActionWidgetState createState() => _MembershipActionWidgetState();
}

class _MembershipActionWidgetState extends State<MembershipActionWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.leagueModel == null ? const Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: LoadingShimmer(),
    ) : content();
  }

  Widget content() {
    return widget.isMember ? stopMembershipAction() : startMembershipButton();
  }

  Widget startMembershipButton() {
    return CardWidget(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ButtonWidget(
            label: "Become a member",
            type: ButtonType.normal,
            onPressed: () {
              widget.onStartMembership.call();
            },
            enabled: widget.leagueModel?.members != null,
          ),
        ),
        ready: widget.leagueModel?.members != null);
  }

  Widget stopMembershipAction() {
    return ExpandedWidget(
        header: Row(
          children: const [
            Icon(Icons.military_tech),
            SpacingWidget(LayoutSize.size16),
            TextWidget(text: "Membership", style: Style.title)
          ],
        ),
        body: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                label: "cancel membership",
                type: ButtonType.normal,
                onPressed: () {
                  widget.onStopMembership.call();
                },
                enabled: widget.leagueModel?.members != null,
              ),
            ),
          )
        ],
        ready: true);
  }
}
