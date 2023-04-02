import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/state/view_state_widget.dart';
import '../../../core/ui/component/ui/spacing_widget.dart';
import '../../../core/ui/view_state.dart';
import '../notification_view_model.dart';

class NotificationListWidget extends StatefulWidget {
  final NotificationViewModel vm;

  const NotificationListWidget(this.vm, {Key? key}) : super(key: key);

  @override
  _NotificationListWidgetState createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget>
    implements BaseSateWidget {
  var isSwitched = false;

  @override
  void initState() {
    observers();
    super.initState();
    widget.vm.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      scrollable: true,
      onBackPressed: onBackPressed,
      state: ViewState.ready,
    );
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.vm.notifications!.isNotEmpty
          ? Column(
              children: notifications(),
            )
          : Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SpacingWidget(LayoutSize.size256),
                  const TextWidget(
                    text: "Inbox empty",
                    style: Style.title,
                  ),
                  const SpacingWidget(LayoutSize.size24),
                  Icon(
                    Icons.manage_search_outlined,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> notifications() {
    return widget.vm.notifications!
        .map((element) => Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  widget.vm.notifications?.remove(element);
                  FirebaseFirestore.instance
                      .runTransaction((Transaction myTransaction) async {
                    myTransaction.delete(element!.reference);
                    widget.vm.fetchNotifications();
                  });
                });
              },
              background: Container(color: Colors.red),
              child: CardWidget(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: element?['message'],
                          style: Style.paragraph,
                          align: TextAlign.start,
                        ),
                      ),
                      element?['action'].toString().isEmpty == true
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  TextWidget(
                                      text: element?['action'],
                                      style: Style.subtitle),
                                  const SpacingWidget(LayoutSize.size8),
                                  IconWidget(
                                    icon: Icons.arrow_forward,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                ],
                              ),
                            ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextWidget(
                              text: element?['date'],
                              style: Style.caption,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onPressed: () {
                    widget.vm.doNavigate(element?['source']);
                  },
                  ready: true),
            ))
        .toList()
        .cast<Widget>();
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
