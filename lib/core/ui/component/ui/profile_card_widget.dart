import 'dart:convert';

import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../home/presentation/home_view_model.dart';
import '../state/loading_rounded_shimmer.dart';

class ProfileCardWidget extends StatelessWidget {
  final HomeViewModel? viewModel;
  final VoidCallback? onPressed;

  const ProfileCardWidget({required this.viewModel, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content(context);
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SpacingWidget(LayoutSize.size8),
              viewModel?.picture == null
                  ? const LoadingRoundedShimmer()
                  : pictureWidget(context),
              const SpacingWidget(LayoutSize.size24),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: viewModel?.profileModel?.firstName,
                    style: Style.title,
                  ),
                  const SpacingWidget(LayoutSize.size8),
                  TextWidget(
                    text: viewModel?.profileModel?.email,
                    style: Style.paragraph,
                  ),
                  const SpacingWidget(LayoutSize.size16),
                ],
              ),
            ],
          ),
          ButtonWidget(
              enabled: true,
              type: ButtonType.iconBorderless,
              icon: Icons.settings,
              onPressed: onPressed),
        ],
      ),
    );
  }

  Widget pictureWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48), // Image radius
                child: Image.memory(
                  base64Decode(viewModel?.picture?.image ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
