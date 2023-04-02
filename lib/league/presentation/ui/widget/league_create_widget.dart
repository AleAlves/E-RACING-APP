import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/dropdown_menu_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/step_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/stepper_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/ui/navigation/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../league_view_model.dart';

class LeagueCreateWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueCreateWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateWidgetState createState() => _LeagueCreateWidgetState();
}

class _LeagueCreateWidgetState extends State<LeagueCreateWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File bannerFile = File('');
  File emblemFile = File('');
  List<String?> tags = [];
  List<TextEditingController> socialStuffControllers = [];
  List<LinkModel?> socialPlatforms = [];
  bool termsAccepted = false;
  bool isFormPending = false;

  @override
  void initState() {
    _nameController.text = '';
    _descriptionController.text = '';
    widget.viewModel.fetchSocialMedias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: createForm(),
      key: _formKey,
    );
  }

  Widget createForm() {
    return StepperWidget(
      steps: <Step>[
        Step(
          title: StepWidget(
            title: 'Basic Info',
            pending: isFormPending,
          ),
          content: basic(),
        ),
        Step(
          title: const StepWidget(
            title: 'Thumbnail',
          ),
          content: emblem(),
        ),
        Step(
          title: const StepWidget(
            title: 'Banner',
          ),
          content: banner(),
        ),
        Step(
          title: const StepWidget(
            title: 'Tags',
          ),
          content: tag(),
        ),
        Step(
          title: const StepWidget(
            title: 'Social',
          ),
          content: social(),
        ),
        Step(
          title: const StepWidget(
            title: 'Agreement',
          ),
          content: terms(),
        ),
      ],
      append: finish(),
      onNext: () {
        setState(() {
          isFormPending =
              _formKey.currentState?.validate() == true ? false : true;
        });
      },
    );
  }

  Widget basic() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            enabled: true,
            label: "Nome",
            icon: Icons.title,
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Name needed';
              }
              return null;
            }),
        const SpacingWidget(LayoutSize.size32),
        InputTextWidget(
            enabled: true,
            label: "Descrição",
            icon: Icons.title,
            controller: _descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Name needed';
              }
              return null;
            },
            inputType: InputType.multilines),
      ],
    );
  }

  Widget tag() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected = tags.contains(item?.id);
                    return ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: selected
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: selected ? const Text('-') : const Text('+'),
                        ),
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          setState(() {
                            selected
                                ? tags.remove(item?.id)
                                : tags.add(item?.id);
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
          );
  }

  Widget emblem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: emblemFile.path == ''
                        ? Container()
                        : Image.file(
                            emblemFile,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                ButtonWidget(
                  type: ButtonType.iconButton,
                  icon: Icons.image_search,
                  onPressed: () async {
                    var image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      emblemFile = File(image?.path ?? '');
                    });
                  },
                  enabled: true,
                )
              ],
            ),
            const TextWidget(
              text: "Thumbnail: 100x100",
              style: Style.caption,
              align: TextAlign.start,
            )
          ],
        )
      ],
    );
  }

  Widget banner() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.height,
                child: bannerFile.path == ''
                    ? Container()
                    : Image.file(
                        bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            ButtonWidget(
                type: ButtonType.iconButton,
                icon: Icons.image_search,
                enabled: true,
                onPressed: () async {
                  var image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    bannerFile = File(image?.path ?? '');
                  });
                })
          ],
        ),
        const TextWidget(
          text: "Banner: 700x100",
          style: Style.caption,
          align: TextAlign.start,
        ),
      ],
    );
  }

  Widget social() {
    return Column(
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: socialPlatforms.length,
          itemBuilder: (context, index) {
            socialStuffControllers.add(TextEditingController());
            return Column(
              children: [
                Row(
                  children: [
                    DropdownMenuWidget(
                      widget.viewModel.socialMedias,
                      (item) {
                        socialPlatforms[index] = LinkModel(
                            item?.id, socialStuffControllers[index].text);
                      },
                      hint: "Platform",
                      currentModel: null,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputTextWidget(
                          enabled: true,
                          label: "Link",
                          icon: Icons.add_link,
                          controller: socialStuffControllers[index],
                          validator: (value) {
                            socialPlatforms[index] = LinkModel(
                                widget.viewModel.socialMedias?[index]?.id ?? '',
                                socialStuffControllers[index].text);
                            return null;
                          }),
                    ),
                    const SpacingWidget(LayoutSize.size8),
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconButton,
                        onPressed: () async {
                          Clipboard.getData(Clipboard.kTextPlain).then((value) {
                            socialStuffControllers[index].text =
                                value?.text?.trim().replaceAll(' ', '') ?? '';
                          });
                        },
                        label: 'paste',
                        icon: Icons.paste),
                    const SpacingWidget(LayoutSize.size8),
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconButton,
                        onPressed: () async {
                          setState(() {
                            socialPlatforms.removeAt(index);
                            socialStuffControllers.removeAt(index);
                          });
                        },
                        label: 'delete',
                        icon: Icons.delete),
                  ],
                ),
              ],
            );
          },
        ),
        const SpacingWidget(LayoutSize.size32),
        ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () async {
              setState(() {
                socialPlatforms.add(LinkModel('', ''));
              });
            },
            label: 'Create'),
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: isValid(),
      type: ButtonType.primary,
      onPressed: () {
        List<int> imageBytes = [];
        List<int> emblemBytes = [];
        try {
          imageBytes = bannerFile.readAsBytesSync();
        } catch (e) {}
        try {
          emblemBytes = emblemFile.readAsBytesSync();
        } catch (e) {}
        String bannerImage = base64Encode(imageBytes);
        String emblem64Image = base64Encode(emblemBytes);
        widget.viewModel.create(
            _nameController.text,
            _descriptionController.text,
            bannerImage,
            emblem64Image,
            tags,
            socialPlatforms);
      },
      label: "Concluir",
    );
  }

  bool isValid() {
    var formValidation =
        _formKey.currentState?.validate() == true && termsAccepted;
    return formValidation;
  }

  Widget terms() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: termsAccepted,
          onChanged: (bool? value) {
            setState(() {
              termsAccepted = value ?? false;
            });
          },
        ),
        const TextWidget(
            text: "I read and accept the terms", style: Style.caption)
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.delete);
    return false;
  }
}
