import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bound_widget.dart';
import 'button_widget.dart';

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
  String? id;

  @override
  void initState() {
    widget.classes?.forEach((clss) {
      clss?.attenders?.forEach((driver) {
        if (driver == Session.instance.getUser()?.id) {
          hasSubscription = true;
          id = clss.id;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ButtonWidget(
            buttonColor: Theme.of(context).colorScheme.secondary,
            labelColor: Theme.of(context).primaryTextTheme.button?.color,
            label: hasSubscription ? "Cancel subscription" : "Subscribe",
            type: ButtonType.normal,
            onPressed: () {
              hasSubscription
                  ? widget.onUnsubscribe.call(id)
                  : actionSubscription();
            },
            enabled: widget.classes != null,
          ),
        ),
        ready: widget.classes != null);
  }

  void actionSubscription() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Column(
                children: [
                  const TextWidget(
                      text: "Choose a class: ", style: Style.title),
                  const BoundWidget(BoundType.huge),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.classes?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 64, right: 64, bottom: 24),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                          child: ButtonWidget(
                            label: widget.classes?[index]?.name,
                            type: ButtonType.important,
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                                widget.onSubscribe.call(widget.classes?[index]?.id);
                              });
                            }, enabled: true,
                          ),
                        ),
                      );
                    },
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
