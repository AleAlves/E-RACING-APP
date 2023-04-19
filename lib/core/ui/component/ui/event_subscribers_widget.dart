import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/legacy/domain/model/profile_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../ext/dialog_extension.dart';
import 'button_widget.dart';

class EventSubscribersWidget extends StatefulWidget {
  final List<ClassesModel?>? classes;
  final List<UserModel?>? users;
  final Function(String, String) onRemove;

  const EventSubscribersWidget(
      {Key? key,
      required this.onRemove,
      required this.classes,
      required this.users})
      : super(key: key);

  @override
  _EventSubscribersWidgetState createState() => _EventSubscribersWidgetState();
}

class _EventSubscribersWidgetState extends State<EventSubscribersWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => subscribers(context);

  Widget subscribers(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                IconWidget(icon: Icons.sports_motorsports),
                SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text: "Drivers",
                  style: Style.title,
                  align: TextAlign.left,
                ),
              ],
            ),
            const SpacingWidget(LayoutSize.size16),
            classesWidget()
          ],
        ),
      ),
      ready: true,
    );
  }

  Widget classesWidget() {
    return Wrap(
      direction: Axis.vertical,
      children: widget.classes!
          .map((classes) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
                  child: TextWidget(
                      text: "${classes?.name}", style: Style.subtitle),
                ),
                drivers(classes)
              ],
            );
          })
          .toList()
          .cast<Widget>(),
    );
  }

  Widget drivers(ClassesModel? classes) {
    return classes!.drivers?.isEmpty == true
        ? Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
            child: Row(
              children: const [
                TextWidget(
                    text: "No drivers in this category", style: Style.caption),
              ],
            ),
          )
        : Wrap(
            children: classes.drivers!
                .map((driver) {
                  var profile = getProfile(driver?.driverId);
                  return CardWidget(
                    ready: true,
                    childLeft: const SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    shapeLess: true,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 48),
                            child: TextWidget(
                                text: "${profile?.name} ${profile?.surname}",
                                style: Style.subtitle),
                          ),
                          const SpacingWidget(LayoutSize.size24),
                          ButtonWidget(
                            enabled: true,
                            type: ButtonType.iconButton,
                            onPressed: () {
                              confirmationDialogExt(
                                context: context,
                                issueMessage:
                                    "Are you sure you want to remove this subscription?",
                                consentMessage: "Yes, I do",
                                onPositive: () {
                                  widget.onRemove.call(
                                    classes.id ?? '',
                                    driver?.driverId ?? '',
                                  );
                                },
                              );
                            },
                            icon: Icons.person_remove,
                          )
                        ],
                      ),
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          );
  }

  ProfileModel? getProfile(id) {
    return widget.users?.firstWhere((element) => element?.id == id)?.profile;
  }
}
