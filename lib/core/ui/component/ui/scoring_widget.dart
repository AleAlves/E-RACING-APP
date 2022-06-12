import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'spacing_widget.dart';
import 'button_widget.dart';

class ScoringWidget extends StatefulWidget {
  final bool editing;
  final List<int?>? scoring;
  final Function(List<int?>) onScore;

  const ScoringWidget(
      {required this.onScore, required this.editing, this.scoring, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _ScoringWidgetState createState() => _ScoringWidgetState();
}

class _ScoringWidgetState extends State<ScoringWidget> {
  List<Pair<int, TextEditingController>> scoringEdit = [];

  @override
  void initState() {
    if (widget.scoring == null && widget.editing == false) {
      defaultScore();
      updateScore();
    } else {
      scoringEdit.clear();
      widget.scoring?.forEach((element) {
        scoringEdit.add(Pair(element, TextEditingController()));
        updateScore();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          if (widget.editing) editting() else Container(),
          Wrap(
            spacing: 0.0,
            children: scoringEdit
                .map((score) {
                  score.second?.text = score.first.toString();
                  var position = scoringEdit.indexOf(score);
                  ++position;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: CardWidget(
                      ready: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextWidget(
                            text: "${position.toString()}°",
                            style: Style.label
                          ),
                          const SpacingWidget(LayoutSize.size8),
                          Column(
                            children: [
                              TextWidget(
                                text: score.first.toString(),
                                style: Style.label,
                              ),
                              const TextWidget(text: "pts", style: Style.label)
                            ],
                          ),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          if (widget.editing) actionTooltip(score);
                        });
                      },
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
          if (widget.editing) actionsWidget() else Container()
        ],
      ),
    );
  }

  Widget editting() {
    return Column(
      children: const [
        TextWidget(text: "Tap to edit", style: Style.description),
        SpacingWidget(LayoutSize.size48)
      ],
    );
  }

  Widget actionsWidget() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size48),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconButton,
                icon: Icons.remove,
                onPressed: () async {
                  setState(() {
                    scoringEdit.removeAt(scoringEdit.length - 1);
                    updateScore();
                  });
                }),
            const SpacingWidget(LayoutSize.size48),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconButton,
                icon: Icons.add,
                onPressed: () async {
                  setState(() {
                    scoringEdit.add(Pair(0, TextEditingController()));
                    updateScore();
                  });
                }),
          ],
        ),
      ],
    );
  }

  void actionTooltip(Pair<int, TextEditingController> score) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height / 5 +
            MediaQuery.of(context).viewInsets.bottom,
        child: Column(
          children: [
            const SpacingWidget(LayoutSize.size16),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: InputTextWidget(
                  enabled: true,
                  label: "Set Score",
                  controller: score.second,
                  inputType: InputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return "invalid score value";
                    }
                  }),
            ),
            const SpacingWidget(LayoutSize.size16),
            ButtonWidget(
                enabled: true,
                label: "apply",
                type: ButtonType.primary,
                icon: Icons.remove,
                onPressed: () async {
                  setState(() {
                    score.first = int.parse(score.second?.text ?? "0");
                    updateScore();
                    Navigator.of(context).pop();
                  });
                }),
          ],
        ),
      ),
    );
  }

  void defaultScore() {
    scoringEdit.add(Pair(25, TextEditingController()));
    scoringEdit.add(Pair(22, TextEditingController()));
    scoringEdit.add(Pair(20, TextEditingController()));
    scoringEdit.add(Pair(18, TextEditingController()));
    scoringEdit.add(Pair(16, TextEditingController()));
    scoringEdit.add(Pair(14, TextEditingController()));
    scoringEdit.add(Pair(12, TextEditingController()));
    scoringEdit.add(Pair(10, TextEditingController()));
    scoringEdit.add(Pair(8, TextEditingController()));
    scoringEdit.add(Pair(6, TextEditingController()));
    scoringEdit.add(Pair(4, TextEditingController()));
    scoringEdit.add(Pair(2, TextEditingController()));
    scoringEdit.add(Pair(1, TextEditingController()));
  }

  void updateScore() {
    var score = scoringEdit.map((e) => e.first);
    widget.onScore.call(score.toList());
  }
}
