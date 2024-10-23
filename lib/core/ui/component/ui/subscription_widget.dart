import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'spacing_widget.dart';

class SubscriptionWidget extends StatefulWidget {
  final List<ClassesModel?>? classes;
  final Function(String?) onSubscribe;
  final Function(String?) onUnsubscribe;

  const SubscriptionWidget(
      {required this.classes,
      required this.onSubscribe,
      required this.onUnsubscribe,
      super.key});

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  SubscriptionWidgetState createState() => SubscriptionWidgetState();
}

class SubscriptionWidgetState extends State<SubscriptionWidget> {
  bool? acceptedTerms = false;
  String? classId;
  String? id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    classId = widget.classes?.first?.id;
    return subscribedWidget();
  }

  Widget subscribedWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          const SpacingWidget(LayoutSize.size16),
          TextWidget(text: "Event registration", style: Style.title),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.classes?.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio<String>(
                        groupValue: classId,
                        value: widget.classes?[index]?.id ?? "",
                        onChanged: (String? value) {
                          setState(() {
                            classId = value;
                          });
                        },
                      ),
                      TextWidget(
                          text: widget.classes?[index]?.name ?? "",
                          style: Style.caption)
                    ],
                  );
                },
              ),
              const SpacingWidget(LayoutSize.size16),
              Row(
                children: [
                  Checkbox(
                    value: acceptedTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        acceptedTerms = value;
                      });
                    },
                  ),
                  Flexible(
                      child: TextWidget(
                    text:
                        "I did read the event's rules and settings and I agree",
                    style: Style.caption,
                    align: TextAlign.start,
                  ))
                ],
              ),
              const SpacingWidget(LayoutSize.size24),
              ButtonWidget(
                label: "Confirm",
                type: ButtonType.primary,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    widget.onSubscribe.call(classId);
                  });
                },
                enabled: acceptedTerms ?? false,
                icon: Icons.directions_car,
              )
            ],
          )
        ],
      ),
    );
  }
}
