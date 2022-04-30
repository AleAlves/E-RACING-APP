import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfileCardWidget extends StatelessWidget {
  final ProfileModel? profileModel;
  final VoidCallback? onPressed;

  const ProfileCardWidget(
      {required this.profileModel, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: content(context),
      onPressed: onPressed,
      ready: true,
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpacingWidget(LayoutSize.size8),
          Row(
            children: [
              Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 48,
              ),
              const SpacingWidget(LayoutSize.size8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextWidget(
                      text: profileModel?.name,
                      style: Style.title,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextWidget(
                      text: profileModel?.email,
                      style: Style.description,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextWidget(
                  text: "My profile",
                  style: Style.description,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
              Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primaryVariant,
                size: 24,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      ),
    );
  }
}
