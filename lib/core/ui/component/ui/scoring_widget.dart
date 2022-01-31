import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'bound_widget.dart';
import 'button_widget.dart';

class ScoringWidget extends StatefulWidget {
  const ScoringWidget({Key? key}) : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _ScoringWidgetState createState() => _ScoringWidgetState();
}

class _ScoringWidgetState extends State<ScoringWidget> {
  final _scoreController = TextEditingController();
  var scoring = [25, 18, 16, 14, 12, 10, 8, 6, 4, 3, 2, 1];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            spacing: 5.0,
            children: scoring
                .map((item) {
                  return CardWidget(
                    color: ERcaingApp.color.shade50,
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => InputTextWidget(
                            label: "Score",
                            controller: _scoreController,
                            validator: (value) {}),
                      );
                    },
                    ready: true,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          text: item.toString(),
                          style: Style.label,
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
          const BoundWidget(BoundType.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  enabled: true,
                  type: ButtonType.icon,
                  icon: Icons.remove,
                  onPressed: () async {
                    setState(() {
                      scoring.removeAt(scoring.length - 1);
                    });
                  }),
              const BoundWidget(BoundType.xl),
              ButtonWidget(
                  enabled: true,
                  type: ButtonType.icon,
                  icon: Icons.add,
                  onPressed: () async {
                    setState(() {
                      scoring.add(0);
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
