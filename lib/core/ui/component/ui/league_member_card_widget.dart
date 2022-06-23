import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/data/league_members_model.dart';
import 'package:flutter/material.dart';

import '../../../ext/dialog_extension.dart';
import 'button_widget.dart';
import 'spacing_widget.dart';

class LeagueMemberCardWidget extends StatelessWidget {
  final LeagueMembersModel? member;
  final bool isHost;
  final Function(String?) onRemove;

  const LeagueMemberCardWidget(
      {required this.member,
      required this.onRemove,
      this.isHost = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: content(context),
      ),
      onPressed: () {},
      ready: true,
    );
  }

  Widget content(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CountryCodePicker(
              onChanged: print,
              showCountryOnly: true,
              enabled: false,
              initialSelection: member?.user.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  TextWidget(
                      text: member?.user.profile?.name, style: Style.subtitle),
                  const SpacingWidget(LayoutSize.size4),
                  TextWidget(
                      text: member?.user.profile?.surname, style: Style.subtitle),
                ],),
                const SpacingWidget(LayoutSize.size8),
                TextWidget(
                    text: "Since ${formatDate(member?.membership.since)}",
                    style: Style.label),
              ],
            )
          ],
        ),
        isHost && Session.instance.getUser()?.id != member?.user.id
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    ButtonWidget(
                      enabled: true,
                      type: ButtonType.iconButton,
                      icon: Icons.delete,
                      onPressed: () {
                        confirmationDialogExt(
                          context: context,
                          issueMessage:
                          "Are you sure you want to remove this member?",
                          consentMessage: "Yes, I do",
                          onPositive: () {
                            onRemove.call(member?.user.id);
                          },
                        );
                      },
                    )
                  ])
            : Container(),
        isHost && Session.instance.getUser()?.id == member?.user.id
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.manage_accounts),
                )])
            : Container(),
      ],
    );
  }
}
