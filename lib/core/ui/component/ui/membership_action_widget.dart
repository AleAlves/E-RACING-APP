import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
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
    return widget.leagueModel == null ? const LoadingShimmer( height: 50,) : content();
  }

  Widget content() {
    return widget.isMember ? stopMembershipAction() : startMembershipButton();
  }

  Widget startMembershipButton() {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ButtonWidget(
        icon: Icons.person_add_outlined,
        label: "Become a member",
        type: ButtonType.important,
        onPressed: () {
          widget.onStartMembership.call();
        },
        enabled: widget.leagueModel?.members != null,
      ),
    );
  }

  Widget stopMembershipAction() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ButtonWidget(
        label: "Membership",
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
        type: ButtonType.secondary,
        onPressed: () {
          widget.onStopMembership.call();
        },
        enabled: widget.leagueModel?.members != null,
      ),
    );
  }
}
