import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return ExpandedWidget(
      header: Row(
        children: [
          Icon(Icons.sports_motorsports, color: Theme.of(context).colorScheme.primaryVariant,),
          const SpacingWidget(LayoutSize.size16),
          const TextWidget(
            text: "Drivers",
            style: Style.title,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        CardWidget(
          child: classes(),
          ready: true,
          shapeLess: true,
        )
      ],
      ready: true,
    );
  }

  Widget classes() {
    return Wrap(
      direction: Axis.vertical,
      children: widget.classes!
          .map((classes) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      TextWidget(
                          text: "${classes?.name}:", style: Style.subtitle),
                    ],
                  ),
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
    return Wrap(
      direction: Axis.vertical,
      spacing: 5.0,
      children: classes!.drivers!
          .map((driver) {
            var profile = getProfile(driver?.driverId);
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CardWidget(
                ready: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: "${profile?.name} ${profile?.surname}", style: Style.subtitle),
                      const SpacingWidget(LayoutSize.size24),
                      ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconBorderless,
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
                        label: "cancel",
                      )
                    ],
                  ),
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
