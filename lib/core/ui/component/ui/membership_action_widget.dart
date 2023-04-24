import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class MembershipActionWidget extends StatefulWidget {
  final bool? hasMembership;
  final bool? isReady;
  final Function onStartMembership;
  final Function onStopMembership;

  const MembershipActionWidget(
      {required this.hasMembership,
      required this.isReady,
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
    return widget.isReady == false
        ? const LoadingShimmer(
            height: 50,
          )
        : content();
  }

  Widget content() {
    return widget.hasMembership == true
        ? stopMembershipAction()
        : startMembershipButton();
  }

  Widget startMembershipButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ButtonWidget(
        icon: Icons.person_add_outlined,
        label: "Become a member",
        type: ButtonType.important,
        onPressed: () {
          widget.onStartMembership.call();
        },
        enabled: widget.isReady == true,
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
        enabled: widget.isReady == true,
      ),
    );
  }
}
