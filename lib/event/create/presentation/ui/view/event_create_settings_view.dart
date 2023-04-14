import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/model/pair_model.dart';
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
  List<SettingsModel?> settingsModel = [];
  List<Pair<TextEditingController, TextEditingController>> settingsControllers =
      [];

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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          guideLines(),
          const SpacingWidget(LayoutSize.size48),
          settingsWidget()
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget guideLines() {
    return const TextWidget(
        text: "You can create the events settings", style: Style.subtitle);
  }

  Widget settingsWidget() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: settingsModel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconButton,
                        icon: Icons.delete,
                        onPressed: () {
                          setState(() {
                            settingsModel.removeAt(index);
                            settingsControllers.removeAt(index);
                          });
                        }),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InputTextWidget(
                            enabled: true,
                            label: "Name",
                            icon: Icons.settings,
                            controller: settingsControllers[index].first,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "required";
                              }
                              return null;
                            }),
                        const SpacingWidget(LayoutSize.size16),
                        InputTextWidget(
                            enabled: true,
                            label: "Value",
                            icon: Icons.settings,
                            controller: settingsControllers[index].second,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "required";
                              }
                              return null;
                            }),
                        const SpacingWidget(LayoutSize.size16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SpacingWidget(LayoutSize.size48),
        ButtonWidget(
            enabled: true,
            type: ButtonType.iconButton,
            icon: Icons.add,
            onPressed: () async {
              setState(() {
                var name = TextEditingController();
                var value = TextEditingController();
                settingsModel
                    .add(SettingsModel(name: name.text, value: value.text));
                settingsControllers.add(Pair(name, value));
              });
            },
            label: 'New setting'),
      ],
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setEventSettings(settingsModel);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.tags);
    return false;
  }
}
