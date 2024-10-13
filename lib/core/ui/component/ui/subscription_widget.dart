import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../ext/dialog_extension.dart';
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
  bool hasSubscription = false;
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
    hasSubscription = widget.classes?.any((clazz) {
          var driver = clazz?.drivers?.firstWhere(
            (driver) => driver?.driverId == Session.instance.getUser()?.id,
            orElse: () => null,
          );
          if (driver != null) {
            id = clazz?.id;
            return true;
          }
          return false;
        }) ??
        false;
    return hasSubscription ? unsubscribedWidget() : subscribedWidget();
  }

  Widget subscribedWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          const SpacingWidget(LayoutSize.size24),
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
              const SpacingWidget(LayoutSize.size24),
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

  Widget unsubscribedWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ButtonWidget(
          label:
              "Registered as ${widget.classes?.firstWhere((element) => element?.id == id)?.name} driver",
          type: ButtonType.secondary,
          icon: Icons.sports_motorsports,
          onPressed: () {
            confirmationDialogExt(
              context: context,
              issueMessage:
                  "Are you sure you want to cancel your registration?",
              consentMessage: "Yes, I do",
              onPositive: () {
                widget.onUnsubscribe.call(id);
              },
            );
          },
          enabled: true,
        ),
      ),
    );
  }
}
