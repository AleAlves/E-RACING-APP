import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/dropdown_menu_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/step_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/stepper_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../detail/presentation/league_detail_view_model.dart';
import '../../detail/presentation/navigation/league_detail_navigation.dart';
import '../../list/data/league_model.dart';

class LeagueUpdateView extends StatefulWidget {
  final LeagueDetailViewModel viewModel;

  const LeagueUpdateView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueUpdateViewState createState() => _LeagueUpdateViewState();
}

class _LeagueUpdateViewState extends State<LeagueUpdateView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File bannerFile = File('');
  List<String?> tags = [];
  List<Pair<LinkModel?, TextEditingController?>> links = [];
  bool isEditingTags = false;
  bool isEditingEmblem = false;
  bool isEditingBanner = false;
  bool isEditingSocialPlatform = false;

  @override
  void initState() {
    super.initState();
    observers();
    widget.viewModel.getLeague();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      scrollable: true,
      state: widget.viewModel.state,
      onBackPressed: onBackPressed,
      floatAction: FloatActionButtonWidget(
        icon: Icons.delete,
        title: "Delete",
        onPressed: () {
          widget.viewModel.onRoute(LeagueDetailNavigationSet.main);
        },
      ),
    );
  }

  @override
  observers() {
    setupProperties();
  }

  @override
  Widget content() {
    return Form(
      child: updateForm(),
      key: _formKey,
    );
  }

  void setupProperties() {
    if (_nameController.text.isEmpty) {
      _nameController.text = widget.viewModel.league?.name ?? '';
    }
    if (_descriptionController.text.isEmpty) {
      _descriptionController.text = widget.viewModel.league?.description ?? '';
    }
    if (tags.isEmpty && !isEditingTags) {
      widget.viewModel.league?.tags?.forEach((element) {
        tags.add(element);
      });
    }
    if (links.isEmpty && !isEditingSocialPlatform) {
      widget.viewModel.league?.links?.forEach((element) {
        var controller = TextEditingController();
        controller.text = element?.link ?? '';
        links.add(Pair<LinkModel, TextEditingController>(element, controller));
      });
    }
  }

  Widget updateForm() {
    return Column(
      children: [
        header(),
        StepperWidget(steps: <Step>[
          Step(
            title: const StepWidget(title: 'Basic Info'),
            content: basic(),
          ),
          Step(
            title: const StepWidget(title: 'Banner'),
            content: banner(),
          ),
          Step(
            title: const StepWidget(title: 'Tags'),
            content: tag(),
          ),
          Step(
            title: const StepWidget(title: 'Social'),
            content: social(),
          ),
        ]),
        finish()
      ],
    );
  }

  Widget header() {
    return Column(
      children: const [
        TextWidget(
          text: "Editing:",
          style: Style.subtitle,
          align: TextAlign.start,
        ),
      ],
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
          inputType: InputType.multilines,
        ),
      ],
    );
  }

  Widget tag() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Wrap(
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
                        isEditingTags = true;
                        setState(() {
                          selected ? tags.remove(item?.id) : tags.add(item?.id);
                        });
                      });
                })
                .toList()
                .cast<Widget>(),
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
                    ? Image.memory(
                        base64Decode(widget.viewModel.media?.image ?? ''),
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            ButtonWidget(
              enabled: true,
              type: ButtonType.iconButton,
              icon: Icons.image_search,
              onPressed: () async {
                var image =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  bannerFile = File(image?.path ?? '');
                });
              },
            )
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
          shrinkWrap: true,
          itemCount: links.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    links[index].first?.platformId == null
                        ? DropdownMenuWidget(
                            widget.viewModel.socialMedias,
                            (item) {
                              isEditingSocialPlatform = true;
                              links[index].first?.platformId = item?.id ?? '';
                            },
                            hint: "Platform",
                            currentModel: null,
                          )
                        : DropdownMenuWidget(
                            widget.viewModel.socialMedias,
                            (item) {
                              isEditingSocialPlatform = true;
                              links[index].first?.platformId = item?.id ?? '';
                            },
                            currentModel: widget.viewModel.socialMedias
                                ?.firstWhere((element) =>
                                    element?.id ==
                                    links[index].first?.platformId),
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
                          controller: links[index].second,
                          validator: (value) {
                            isEditingSocialPlatform = true;
                            links[index].second?.text = value ?? '';
                            return null;
                          }),
                    ),
                    const SpacingWidget(LayoutSize.size8),
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.iconButton,
                        onPressed: () async {
                          isEditingSocialPlatform = true;
                          Clipboard.getData(Clipboard.kTextPlain).then((value) {
                            links[index].second?.text =
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
                          isEditingSocialPlatform = true;
                          setState(() {
                            links.removeAt(index);
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
            type: ButtonType.link,
            onPressed: () async {
              setState(() {
                links
                    .add(Pair(LinkModel.fromJson({}), TextEditingController()));
              });
            },
            label: 'New link'),
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          List<int> bannerBytes = [];
          List<LinkModel?> linksList = [];
          try {
            bannerBytes = bannerFile.readAsBytesSync();
          } catch (e) {}
          String bannerImage = base64Encode(bannerBytes);
          for (var element in links) {
            element.first?.link = element.second?.text ?? '';
            linksList.add(element.first);
          }
          var league = LeagueModel(
              id: widget.viewModel.league?.id,
              owner: widget.viewModel.league?.owner,
              name: _nameController.text,
              description: _descriptionController.text,
              capacity: widget.viewModel.league?.capacity,
              members: widget.viewModel.league?.members,
              tags: tags,
              links: linksList);
          var media = MediaModel(
              bannerImage.isEmpty ? widget.viewModel.media!.image : bannerImage,
              origin: league.id);
          widget.viewModel.update(league, media);
        }
      },
      label: "Update",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(LeagueDetailNavigationSet.main);
    return false;
  }
}
