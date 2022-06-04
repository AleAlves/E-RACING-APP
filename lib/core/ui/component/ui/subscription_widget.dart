import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ext/dialog_extension.dart';
import 'spacing_widget.dart';
import 'button_widget.dart';
import 'expanded_widget.dart';

class SubscriptionWidget extends StatefulWidget {
  final List<ClassesModel?>? classes;
  final Function(String?) onSubscribe;
  final Function(String?) onUnsubscribe;

  const SubscriptionWidget(
      {required this.classes,
      required this.onSubscribe,
      required this.onUnsubscribe,
      Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _SubscriptionWidgetState createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  bool hasSubscription = false;
  bool? acceptedTerms = false;
  String? id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.classes?.forEach((clss) {
      clss?.drivers?.forEach((driver) {
        if (driver?.driverId == Session.instance.getUser()?.id) {
          hasSubscription = true;
          id = clss.id;
        }
      });
    });
    return hasSubscription ? subscribedWidget() : unsubscribedWidget();
  }

  Widget unsubscribedWidget() {
    return CardWidget(
        shapeLess: true,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ButtonWidget(
              label: "Registration",
              type: ButtonType.normal,
              icon: Icons.how_to_reg_outlined,
              onPressed: () {
                handleChoice();
              },
              enabled: widget.classes != null,
            ),
          ),
        ),
        ready: widget.classes != null);
  }

  void handleChoice() {
    var size = widget.classes?.length.toInt() ?? 0;
    if (size > 1) {
      actionSubscription();
    } else {
      widget.onSubscribe.call(widget.classes?.first?.id);
    }
  }

  void actionSubscription() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) => SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpacingWidget(LayoutSize.size24),
                    const TextWidget(
                        text: "Choose a class: ", style: Style.title),
                    const SpacingWidget(LayoutSize.size32),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.classes?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 64, right: 64, bottom: 24),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 10,
                            child: ButtonWidget(
                              label: widget.classes?[index]?.name,
                              type: ButtonType.normal,
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                  widget.onSubscribe
                                      .call(widget.classes?[index]?.id);
                                });
                              },
                              enabled: acceptedTerms ?? false,
                            ),
                          ),
                        );
                      },
                    ),
                    const SpacingWidget(LayoutSize.size8),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: acceptedTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                acceptedTerms = value;
                              });
                            },
                          ),
                          const TextWidget(
                              text:
                                  "I did read the event's rules and settings and I agree",
                              style: Style.label)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget subscribedWidget() {
    return CardWidget(
        shapeLess: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonWidget(
                  label:
                      "Registered as ${widget.classes?.firstWhere((element) => element?.id == id)?.name} driver",
                  type: ButtonType.discret,
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
            )
          ],
        ),
        ready: true);
  }
}
