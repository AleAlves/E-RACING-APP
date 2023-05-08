import 'package:flutter/material.dart';

class StepProgressIndicatorWidget extends StatefulWidget {
  final int maxSteps;
  final int currentStep;

  const StepProgressIndicatorWidget(
      {required this.maxSteps, required this.currentStep, Key? key})
      : super(key: key);

  @override
  _StepProgressIndicatorWidgetState createState() =>
      _StepProgressIndicatorWidgetState();
}

class _StepProgressIndicatorWidgetState
    extends State<StepProgressIndicatorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => content();

  Widget content() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < widget.maxSteps; i++)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.002,
                          color: i >= widget.currentStep
                              ? Theme.of(context).focusColor
                              : Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
