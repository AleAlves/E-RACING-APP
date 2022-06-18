import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  final List<Step> steps;
  final Widget? append;
  final Function()? onNext;

  const StepperWidget({required this.steps, this.append, this.onNext, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => stepper();

  Widget stepper() {
    return SizedBox(
      child: Column(
        children: [
          Stepper(
            physics: const ClampingScrollPhysics(),
            currentStep: _index,
            controlsBuilder: (context, _) {
              return _index == (widget.steps.length - 1)
                  ? Container()
                  : Column(
                      children: [
                        const SpacingWidget(LayoutSize.size16),
                        Row(
                          children: <Widget>[
                            ButtonWidget(
                                enabled: true,
                                label: "Done",
                                type: ButtonType.link,
                                onPressed: () {
                                  setState(() {
                                    _index += 1;
                                    widget.onNext?.call();
                                  });
                                })
                          ],
                        ),
                      ],
                    );
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
                widget.onNext?.call();
              });
            },
            steps: widget.steps,
          ),
          const SpacingWidget(LayoutSize.size48),
          widget.append ?? Container()
        ],
      ),
    );
  }
}
