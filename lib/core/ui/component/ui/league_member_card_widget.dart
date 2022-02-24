import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'button_widget.dart';
import 'spacing_widget.dart';

class EventMemberCardWidget extends StatelessWidget {
  final UserModel? user;
  final bool isHost;
  final Function(String?) onRemove;

  const EventMemberCardWidget(
      {required this.user,
      required this.onRemove,
      this.isHost = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              initialSelection: user?.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
            const SpacingWidget(LayoutSize.size4),
            TextWidget(text: user?.profile?.name, style: Style.subtitle),
            const SpacingWidget(LayoutSize.size4),
            TextWidget(text: user?.profile?.surname, style: Style.subtitle)
          ],
        ),
        isHost && Session.instance.getUser()?.id != user?.id
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    ButtonWidget(
                      enabled: true,
                      type: ButtonType.iconBorderless,
                      icon: Icons.delete_forever,
                      onPressed: () {
                        onRemove.call(user?.id);
                      },
                    )
                  ])
            : Container(),
        isHost && Session.instance.getUser()?.id == user?.id
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Icon(Icons.manage_accounts)])
            : Container(),
      ],
    );
  }
}
