import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'spacing_widget.dart';

class SettingsWidget extends StatefulWidget {
  final List<SettingsModel?>? settings;

  const SettingsWidget({required this.settings, Key? key}) : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.settings == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.spaceEvenly,
              direction: Axis.horizontal,
              spacing: 5.0,
              children: widget.settings!
                  .map((score) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 48, right: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(text: "${score?.name}:", style: Style.description),
                              TextWidget(text: score?.value, style: Style.description)
                            ],
                          ),
                          const SpacingWidget(LayoutSize.size16),
                        ],
                      ),
                    );
                  })
                  .toList()
                  .cast<Widget>(),
            ),
            const SpacingWidget(LayoutSize.size16),
          ],
        ),
      );
    }
  }
}
