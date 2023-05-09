import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../profile/domain/model/profile_model.dart';
import '../../../ext/dialog_extension.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size48),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
        ),
        const SpacingWidget(LayoutSize.size16),
        classesWidget()
      ],
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
                Row(
                  children: [
                    const SpacingWidget(LayoutSize.size16),
                    TextWidget(text: "${classes?.name}", style: Style.subtitle),
                  ],
                ),
                const SpacingWidget(LayoutSize.size16),
                drivers(classes),
                const SpacingWidget(LayoutSize.size48),
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
            direction: Axis.vertical,
            children: classes.drivers!
                .map((driver) {
                  var profile = getProfile(driver?.driverId);
                  return SizedBox(
                    width: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width * 0.05),
                    child: CardWidget(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Wrap(
                              children: [
                                TextWidget(
                                    text:
                                        "${profile?.firstName} ${profile?.surName}",
                                    style: Style.subtitle),
                              ],
                            ),
                          ],
                        ),
                      ),
                      childRight: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconWidget(
                          icon: Icons.person_remove,
                        ),
                      ),
                      ready: true,
                      onPressed: () {
                        _showRemoveDriver(driver?.driverId, classes);
                      },
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          );
  }

  _showRemoveDriver(String? driverId, ClassesModel classes) {
    confirmationDialogExt(
      context: context,
      issueMessage: "Are you sure you want to remove this subscription?",
      consentMessage: "Yes, I do",
      onPositive: () {
        widget.onRemove.call(
          classes.id ?? '',
          driverId ?? '',
        );
      },
    );
  }

  ProfileModel? getProfile(id) {
    return widget.users?.firstWhere((element) => element?.id == id)?.profile;
  }
}
