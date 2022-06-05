import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
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
      content: content(),
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
                    text: "No new notifications",
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
        .map((element) => CardWidget(
            marked: element?['important'],
            markColor: Theme.of(context).colorScheme.primary,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: TextWidget(
                            text: element?['message'],
                            style: Style.subtitle,
                            align: TextAlign.start,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextWidget(
                              text: element?['date'],
                              style: Style.note,
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.primary,)
                        ],
                      ),
                    ],
                  ),
                  ButtonWidget(
                    enabled: true,
                    type: ButtonType.iconBorderless,
                    onPressed: () {
                      FirebaseFirestore.instance
                          .runTransaction((Transaction myTransaction) async {
                        myTransaction.delete(element!.reference);
                        widget.vm.fetchNotifications();
                      });
                    },
                    iconColor: Colors.red,
                    icon: Icons.highlight_off_outlined,
                  )
                ],
              ),
            ),
            onPressed: (){
              widget.vm.doNavigate(element?['source']);
            },
            ready: true))
        .toList()
        .cast<Widget>();
  }

  @override
  observers() {
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
