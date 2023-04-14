import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/model/classes_model.dart';
import '../../../../../core/model/pair_model.dart';
import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateClassesView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateClassesView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateClassesViewState createState() => _EventCreateClassesViewState();
}

class _EventCreateClassesViewState extends State<EventCreateClassesView>
    implements BaseSateWidget {
  List<ClassesModel?> classesModel = [];
  List<Pair<TextEditingController, TextEditingController>> classesControllers =
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
      bottom: buttonWidget(),
      scrollable: false,
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size48),
        titleWidget(),
        const SpacingWidget(LayoutSize.size32),
        classesWidget()
      ],
    );
  }

  @override
  observers() {}

  Widget titleWidget() {
    return const TextWidget(
        text: "Define the car classes", style: Style.subtitle);
  }

  Widget classesWidget() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: classesModel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconButton,
                        icon: Icons.delete,
                        onPressed: () {
                          setState(() {
                            classesModel.removeAt(index);
                            classesControllers.removeAt(index);
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
                            controller: classesControllers[index].first,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "required";
                              }
                              return null;
                            }),
                        const SpacingWidget(LayoutSize.size16),
                        InputTextWidget(
                          enabled: true,
                          label: "Max entries",
                          icon: Icons.settings,
                          controller: classesControllers[index].second,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                          inputType: InputType.number,
                        ),
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
                classesModel.add(ClassesModel(name: name.text));
                classesControllers.add(Pair(name, value));
              });
            },
            label: 'Create class'),
      ],
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setEventClasses(classesModel);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.banner);
    return false;
  }
}
