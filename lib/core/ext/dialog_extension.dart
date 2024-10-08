import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

confirmationDialogExt(
    {required BuildContext context,
    required String issueMessage,
    required String consentMessage,
    required Function() onPositive}) {
  bool termsAccepted = false;
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, myState) {
            return Wrap(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SpacingWidget(LayoutSize.size16),
                        TextWidget(text: issueMessage, style: Style.subtitle),
                        const SpacingWidget(LayoutSize.size48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: termsAccepted,
                              onChanged: (bool? value) {
                                myState(() {
                                  termsAccepted = value ?? false;
                                });
                              },
                            ),
                            TextWidget(
                                text: consentMessage, style: Style.caption),
                            const SpacingWidget(LayoutSize.size24),
                          ],
                        ),
                        const SpacingWidget(LayoutSize.size32),
                        ButtonWidget(
                          label: "Confirm",
                          type: ButtonType.primary,
                          onPressed: () {
                            onPositive.call();
                            Navigator.of(context).pop();
                          },
                          enabled: termsAccepted,
                        ),
                        const SpacingWidget(LayoutSize.size16),
                      ],
                    ),
                  ),
                )
              ],
            );
          }));
}

showAlertExt(
    {required BuildContext context,
      required String message}) {
  showModalBottomSheet(
      isDismissible: true,
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
                          TextWidget(text: message, style: Style.subtitle),
                          const SpacingWidget(LayoutSize.size16),
                          ButtonWidget(
                            label: "Confirm",
                            type: ButtonType.primary,
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
