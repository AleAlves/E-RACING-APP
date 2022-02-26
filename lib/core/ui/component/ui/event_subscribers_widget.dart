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
      body: [
        CardWidget(
          child: classes(),
          ready: true,
          shapeLess: true,
        )
      ],
      ready: true,
      header: Row(
        children: const [
          Icon(Icons.sports_motorsports),
          SpacingWidget(LayoutSize.size16),
          TextWidget(
            text: "Subscribers",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget classes() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      direction: Axis.vertical,
      spacing: 5.0,
      children: widget.classes!
          .map((classes) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      direction: Axis.vertical,
      spacing: 5.0,
      children: classes!.drivers!
          .map((driver) {
            var profile = getProfile(driver?.driverId);
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CardWidget(
                ready: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: "${profile?.name}", style: Style.subtitle),
                    const SpacingWidget(LayoutSize.size8),
                    TextWidget(
                        text: "${profile?.surname}", style: Style.subtitle),
                    const SpacingWidget(LayoutSize.size16),
                    ButtonWidget(
                      enabled: true,
                      type: ButtonType.iconBorderless,
                      onPressed: () {
                        showAlert(() {
                          widget.onRemove.call(
                            classes.id ?? '',
                            driver?.driverId ?? '',
                          );
                        });
                      },
                      icon: Icons.person_remove,
                      label: "remove",
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

  showAlert(Function() onPositive) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return SizedBox(
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SpacingWidget(LayoutSize.size16),
                            const TextWidget(
                                text:
                                    "Are you sure you want to remove this subscription?",
                                style: Style.subtitle),
                            const SpacingWidget(LayoutSize.size48),
                            ButtonWidget(
                              label: "Yes I do",
                              type: ButtonType.important,
                              onPressed: () {
                                onPositive.call();
                                Navigator.of(context).pop();
                              },
                              enabled: true,
                            ),
                            const SpacingWidget(LayoutSize.size24),
                            ButtonWidget(
                              label: "No I don't",
                              type: ButtonType.normal,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              enabled: true,
                            ),
                            const SpacingWidget(LayoutSize.size16),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  ProfileModel? getProfile(id) {
    return widget.users?.firstWhere((element) => element?.id == id)?.profile;
  }
}
