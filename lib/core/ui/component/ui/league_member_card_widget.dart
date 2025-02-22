import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/date_extensions.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/chip_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../league/member/data/league_members_model.dart';
import '../../../ext/dialog_extension.dart';
import 'button_widget.dart';
import 'spacing_widget.dart';

class LeagueMemberCardWidget extends StatelessWidget {
  final LeagueMembersModel? member;
  final Function(String?) onRemove;

  const LeagueMemberCardWidget(
      {required this.member, required this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      childRight: Column(
        children: [
          member?.membership.isAdmin == false &&
                  Session.instance.getUser()?.id != member?.user.id
              ? Row(children: [
                  ButtonWidget(
                    enabled: true,
                    type: ButtonType.iconShapeless,
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
          member?.membership.isAdmin == true &&
              Session.instance.getUser()?.id == member?.user.id
              ? Column(
            children: [
              const SpacingWidget(LayoutSize.size8),
              ChipWidget(
                text: "Admin",
                color: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SpacingWidget(LayoutSize.size8),
            ],
          )
              : Container(),
        ],
      ),
      ready: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Row(
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                    text: member?.user.profile?.firstName,
                    style: Style.paragraph),
                const SpacingWidget(LayoutSize.size4),
                TextWidget(
                    text: member?.user.profile?.surName,
                    style: Style.paragraph),
              ],
            ),
            const SpacingWidget(LayoutSize.size8),
            TextWidget(
                text: "Since ${formatDate(member?.membership.since)}",
                style: Style.caption),
          ],
        ),
      ],
    );
  }
}
