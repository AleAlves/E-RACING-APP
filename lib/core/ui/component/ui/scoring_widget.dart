import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'input_text_widget.dart';
import 'spacing_widget.dart';

class ScoringWidget extends StatefulWidget {
  final bool editing;
  final List<int?>? scoring;

  const ScoringWidget({required this.editing, required this.scoring, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _ScoringWidgetState createState() => _ScoringWidgetState();
}

class _ScoringWidgetState extends State<ScoringWidget> {
  var isValid = false;
  final _scoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scoreController.addListener(() {
      final String text = _scoreController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var position = -1;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Wrap(
            spacing: 0.0,
            children: widget.scoring!
                .map((score) {
                  var pos = ++position;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: CardWidget(
                      childLeft: TextWidget(
                          text: "${position + 1}°", style: Style.caption),
                      ready: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextWidget(
                            text: score.toString(),
                            style: Style.caption,
                          ),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          if (widget.editing) {
                            createScoreBottomSheet(score!, pos);
                          }
                        });
                      },
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
          if (widget.editing) editting() else Container(),
          // if (widget.editing) actionsWidget() else Container()
        ],
      ),
    );
  }

  Widget editting() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size48),
        widget.scoring?.isEmpty == true
            ? Container()
            : const TextWidget(text: "Tap to edit", style: Style.paragraph),
        const SpacingWidget(LayoutSize.size48)
      ],
    );
  }

  void createScoreBottomSheet(int score, int position) {
    _scoreController.clear();
    _scoreController.text = score == null ? "" : score.toString();
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, modelState) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SpacingWidget(LayoutSize.size16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            text:
                                "Set the points worthy for the ${widget.scoring?.length} position",
                            style: Style.paragraph),
                        ButtonWidget(
                            enabled: true,
                            type: ButtonType.iconBorderless,
                            icon: Icons.delete_forever,
                            label: "Delete",
                            onPressed: () async {
                              setState(() {
                                widget.scoring?.removeLast();
                                Navigator.of(context).pop();
                              });
                            }),
                      ],
                    ),
                    const SpacingWidget(LayoutSize.size48),
                    InputTextWidget(
                        enabled: true,
                        label: "Score",
                        controller: _scoreController,
                        inputType: InputType.number,
                        validator: (value) {
                          if (value == null || double.tryParse(value) == null) {
                            return "invalid score value";
                          }
                        }),
                    const SpacingWidget(LayoutSize.size48),
                    ButtonWidget(
                        enabled: _scoreController.text.isNotEmpty,
                        label: "Update",
                        type: ButtonType.primary,
                        onPressed: () async {
                          setState(() {
                            widget.scoring?[position] =
                                (int.parse(_scoreController.text));
                            Navigator.of(context).pop();
                          });
                        }),
                    const SpacingWidget(LayoutSize.size16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
