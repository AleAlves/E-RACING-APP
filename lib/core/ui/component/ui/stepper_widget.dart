import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  final List<Step> steps;
  final Widget? append;

  const StepperWidget({required this.steps, this.append, Key? key})
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
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            controlsBuilder: (BuildContext context,
                {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              return const Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: SizedBox()
              );
            },
            steps: widget.steps,
          ),
          widget.append ?? Container()
        ],
      ),
    );
  }
}
