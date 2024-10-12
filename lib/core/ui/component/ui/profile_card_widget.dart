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
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          viewModel?.picture == null
              ? const LoadingRoundedShimmer()
              : Column(
                  children: [
                    pictureWidget(context),
                    const SpacingWidget(LayoutSize.size16),
                  ],
                ),
          const SpacingWidget(LayoutSize.size8),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    TextWidget(
                      text: viewModel?.profileModel?.firstName,
                      style: Style.title,
                    ),
                    TextWidget(
                      text: viewModel?.profileModel?.email,
                      style: Style.paragraph,
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                  enabled: true,
                  type: ButtonType.link,
                  label: "Edit profile",
                  onPressed: onPressed),
            ],
          ),
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
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
