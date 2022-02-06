import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bound_widget.dart';

class PilotsWidget extends StatefulWidget {
  final List<SettingsModel?>? settings;

  const PilotsWidget({required this.settings, Key? key}) : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _PilotsWidgetState createState() => _PilotsWidgetState();
}

class _PilotsWidgetState extends State<PilotsWidget> {
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
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 5.0,
              children: widget.settings!
                  .map((score) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          TextWidget(text: "${score?.name}:", style: Style.subtitle),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextWidget(text: score?.value, style: Style.subtitle),
                          ),
                        ],
                      ),
                    );
                  })
                  .toList()
                  .cast<Widget>(),
            ),
            const BoundWidget(BoundType.size48),
          ],
        ),
      );
    }
  }
}
