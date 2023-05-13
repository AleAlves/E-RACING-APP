import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/model/settings_model.dart';
import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateSettingsView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateSettingsView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateSettingsViewState createState() =>
      _EventCreateSettingsViewState();
}

class _EventCreateSettingsViewState extends State<EventCreateSettingsView>
    implements BaseSateWidget {
  final _settingsNameController = TextEditingController();
  final _settingsValueController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
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
      bottom: button(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SpacingWidget(LayoutSize.size128),
        guideLines(),
        const SpacingWidget(LayoutSize.size48),
        settingsWidget(),
        const SpacingWidget(LayoutSize.size48),
        createSettingButton()
      ],
    );
  }

  @override
  observers() {}

  Widget guideLines() {
    return const TextWidget(
        text: "You can create the events settings", style: Style.subtitle);
  }

  Widget settingsWidget() {
    return Wrap(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.viewModel.eventSettings.length,
          itemBuilder: (context, index) {
            return CardWidget(
                childLeft: ButtonWidget(
                    enabled: true,
                    type: ButtonType.iconShapeless,
                    icon: Icons.delete,
                    onPressed: () {
                      setState(() {
                        widget.viewModel.eventSettings.removeAt(index);
                        // settingsControllers.removeAt(index);
                      });
                    }),
                child: Row(
                  children: [
                    TextWidget(
                        text: widget.viewModel.eventSettings[index]?.name,
                        style: Style.caption),
                    const SpacingWidget(LayoutSize.size8),
                    const TextWidget(text: ":", style: Style.caption),
                    const SpacingWidget(LayoutSize.size8),
                    TextWidget(
                        text: widget.viewModel.eventSettings[index]?.value,
                        style: Style.caption)
                  ],
                ),
                ready: true);
          },
        ),
        const SpacingWidget(LayoutSize.size48),
      ],
    );
  }

  Widget createSettingButton() {
    return ButtonWidget(
        enabled: true,
        type: ButtonType.icon,
        icon: Icons.add,
        onPressed: () async {
          setState(() {
            createSettingBottomSheet();
          });
        },
        label: 'New setting');
  }

  createSettingBottomSheet() {
    _settingsNameController.clear();
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, modelState) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SpacingWidget(LayoutSize.size48),
                    InputTextWidget(
                        enabled: true,
                        label: "Name",
                        controller: _settingsNameController,
                        inputType: InputType.text,
                        validator: (value) {
                          return null;
                        }),
                    const SpacingWidget(LayoutSize.size16),
                    InputTextWidget(
                        enabled: true,
                        label: "Value",
                        controller: _settingsValueController,
                        inputType: InputType.text,
                        validator: (value) {
                          return null;
                        }),
                    const SpacingWidget(LayoutSize.size48),
                    ButtonWidget(
                        enabled: _settingsNameController.text.isNotEmpty,
                        label: "apply",
                        type: ButtonType.primary,
                        onPressed: () async {
                          setState(() {
                            widget.viewModel.eventSettings.add(SettingsModel(
                                name: _settingsNameController.text,
                                value: _settingsValueController.text));
                            Navigator.of(context).pop();
                          });
                        }),
                    const SpacingWidget(LayoutSize.size16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.onFinishEventSettings();
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    widget.viewModel.onRoute(EventCreateNavigator.eventTags);
    return false;
  }
}
