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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < widget.maxSteps; i++)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Theme.of(context).colorScheme.primary,
                        size: 16,
                      ),
                      Icon(
                        Icons.circle,
                        color: i >= widget.currentStep
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        size: 12,
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
