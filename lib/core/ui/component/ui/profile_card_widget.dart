import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:flutter/material.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpacingWidget(LayoutSize.size16),
                  TextWidget(
                    text: profileModel?.name,
                    style: Style.title,
                  ),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                    text: profileModel?.email,
                    style: Style.description,
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "My profile",
                        style: Style.description,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.account_circle,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
    );
  }
}
