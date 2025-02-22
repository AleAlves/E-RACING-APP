import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
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

class EventCreateClassesView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateClassesView(this.viewModel, {super.key});

  @override
  EventCreateClassesViewState createState() => EventCreateClassesViewState();
}

class EventCreateClassesViewState extends State<EventCreateClassesView>
    implements BaseSateWidget {
  var hasName = false;
  var hasEntries = false;
  final Pair<TextEditingController, TextEditingController> _classesControllers =
      Pair(TextEditingController(), TextEditingController());

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
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size24),
        title(),
        const SpacingWidget(LayoutSize.size32),
        classesWidget()
      ],
    );
  }

  @override
  observers() {
    _classesControllers.first?.addListener(() {
      setState(() {
        hasName = _classesControllers.first?.text.isNotEmpty ?? false;
      });
    });
    _classesControllers.second?.addListener(() {
      setState(() {
        hasEntries = _classesControllers.second?.text.isNotEmpty ?? false;
      });
    });
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(
        text: "Classes/Categories",
        style: Style.title,
        align: TextAlign.start,
      ),
    );
  }

  Widget classesWidget() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.viewModel.eventClasses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardWidget(
                ready: true,
                childLeft: ButtonWidget(
                    enabled: true,
                    type: ButtonType.iconShapeless,
                    icon: Icons.delete,
                    onPressed: () {
                      setState(() {
                        widget.viewModel.removeClasses(index);
                      });
                    }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const TextWidget(
                              text: "Class/Category:  ", style: Style.paragraph),
                          TextWidget(
                              text:
                                  widget.viewModel.eventClasses[index]?.name ??
                                      "",
                              style: Style.caption),
                        ],
                      ),
                      Row(
                        children: [
                          const TextWidget(
                              text: "Entries:  ", style: Style.paragraph),
                          TextWidget(
                              text: widget
                                  .viewModel.eventClasses[index]?.maxEntries
                                  .toString(),
                              style: Style.caption),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SpacingWidget(LayoutSize.size48),
        ButtonWidget(
            enabled: true,
            type: ButtonType.icon,
            icon: Icons.add,
            onPressed: () async {
              setState(() {
                _classesControllers.first?.clear();
                _classesControllers.second?.clear();
                newClassWidget();
              });
            },
            label: 'Create new'),
      ],
    );
  }

  newClassWidget() {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, modelState) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextWidget(text: "Class/Category", style: Style.paragraph),
                  const SpacingWidget(LayoutSize.size16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InputTextWidget(
                                enabled: true,
                                label: "Name",
                                inputType: InputType.capital,
                                controller: _classesControllers.first,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                }),
                            const SpacingWidget(LayoutSize.size8),
                            InputTextWidget(
                                enabled: true,
                                label: "Entries",
                                inputType: InputType.number,
                                controller: _classesControllers.second,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ButtonWidget(
                        enabled: hasName && hasEntries,
                        type: ButtonType.primary,
                        label: "Create",
                        onPressed: () {
                          setState(() {
                            widget.viewModel.addEventClasses(ClassesModel(
                                name: _classesControllers.first?.text,
                                maxEntries: int.parse(_classesControllers
                                        .second?.text
                                        .toString() ??
                                    "")));
                            Navigator.pop(context);
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: widget.viewModel.eventClasses.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.increaseStep();
        widget.viewModel.onFinishClasses();
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    return false;
  }
}
