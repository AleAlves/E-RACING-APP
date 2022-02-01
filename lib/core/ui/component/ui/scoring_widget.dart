import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  var scoring = [
    Pair(25, TextEditingController()),
    Pair(18, TextEditingController()),
    Pair(14, TextEditingController()),
    Pair(12, TextEditingController()),
    Pair(10, TextEditingController()),
    Pair(8, TextEditingController()),
    Pair(6, TextEditingController()),
    Pair(4, TextEditingController()),
    Pair(3, TextEditingController()),
    Pair(2, TextEditingController()),
    Pair(1, TextEditingController()),
  ];

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
          const TextWidget(text: "Tap to edit", style: Style.description),
          const BoundWidget(BoundType.xl),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            spacing: 5.0,
            children: scoring
                .map((score) {
                  score.second?.text = score.first.toString();
                  return CardWidget(
                    color: ERcaingApp.color.shade50,
                    ready: true,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          text: score.first.toString(),
                          style: Style.label,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height / 5 +
                              MediaQuery.of(context).viewInsets.bottom,
                            child: Column(
                              children: [
                                const BoundWidget(BoundType.medium),
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: InputTextWidget(
                                      label: "Set Score",
                                      controller: score.second,
                                      inputType: InputType.number,
                                      validator: (value) {
                                        if (value == null || double.tryParse(value) == null) {
                                          return "invalid score value";
                                        }
                                      }),
                                ),
                                const BoundWidget(BoundType.medium),
                                ButtonWidget(
                                    enabled: true,
                                    label: "apply",
                                    type: ButtonType.normal,
                                    icon: Icons.remove,
                                    onPressed: () async {
                                      setState(() {
                                        score.first = int.parse(
                                            score.second?.text ?? "0");
                                        Navigator.of(context).pop();
                                      });
                                    }),
                              ],
                            ),
                          ),
                        );
                      });
                    },
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
                      scoring.add(Pair(0, TextEditingController()));
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
