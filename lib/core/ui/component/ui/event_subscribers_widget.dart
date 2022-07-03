import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
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
            classes(),
          ],
        ),
      ),
      ready: true,
    );
  }

  Widget classes() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.classes?.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
              child: TextWidget(
                  text: "${widget.classes?[index]?.name}",
                  style: Style.subtitle),
            ),
            drivers(widget.classes?[index])
          ],
        );
      },
    );
  }

  Widget drivers(ClassesModel? classes) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: classes?.drivers?.length,
      itemBuilder: (context, index) {
        var profile = getProfile(classes?.drivers?[index]?.driverId);
        return CardWidget(
          ready: true,
          childLeft: const SizedBox(width: 8, height: 8,),
          shapeLess: true,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
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
                          classes?.id ?? '',
                          classes?.drivers?[index]?.driverId ?? '',
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
      },
    );
  }

  ProfileModel? getProfile(id) {
    return widget.users?.firstWhere((element) => element?.id == id)?.profile;
  }
}
