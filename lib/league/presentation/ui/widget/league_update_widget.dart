import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/dropdown_menu_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../league_flow.dart';

class LeagueUpdateWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueUpdateWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueUpdateWidgetState createState() => _LeagueUpdateWidgetState();
}

class _LeagueUpdateWidgetState extends State<LeagueUpdateWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  int _index = 0;
  File bannerFile = File('');
  File emblemFile = File('');
  List<String?> tags = [];
  List<Pair<LinkModel?, TextEditingController?>> links = [];
  bool isEditingTags = false;
  bool isEditingEmblem = false;
  bool isEditingBanner = false;
  bool isEditingSocialPlatform = false;

  @override
  void initState() {
    widget.viewModel.getLeague();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  observers() {}

  @override
  Widget content() {
    setupProperties();
    return Stack(
      children: [
        Form(
          child: updateForm(),
          key: _formKey,
        ),
        FloatActionButtonWidget<LeagueFlow>(
          flow: LeagueFlow.delete,
          icon: Icons.delete,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          header(),
          Stepper(
            currentStep: _index,
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            controlsBuilder: (BuildContext context,
                {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              return Row(
                children: <Widget>[
                  Container(),
                  Container(),
                ],
              );
            },
            steps: <Step>[
              Step(
                title: const Text('Basic Info'),
                content: basic(),
              ),
              Step(
                title: const Text('Emblem'),
                content: emblem(),
              ),
              Step(
                title: const Text('Banner'),
                content: banner(),
              ),
              Step(
                title: const Text('Tags'),
                content: tag(),
              ),
              Step(
                title: const Text('Social'),
                content: social(),
              ),
            ],
          ),
          finish()
        ],
      ),
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
        const BoundWidget(BoundType.huge),
        InputTextWidget(
            label: "Nome",
            icon: Icons.title,
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Name needed';
              }
              return null;
            }),
        const BoundWidget(BoundType.huge),
        InputTextWidget(
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
                            ? ERcaingApp.color.shade200
                            : ERcaingApp.color,
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

  Widget emblem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
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
                    child: emblemFile.path.isEmpty
                        ? Image.memory(
                            base64Decode(widget.viewModel.league?.emblem ?? ''),
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            emblemFile,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                IconButtonWidget(Icons.image_search, () async {
                  var image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    emblemFile = File(image?.path ?? '');
                  });
                })
              ],
            ),
            const TextWidget(
              text: "Emblem: 100x100",
              style: Style.label,
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
            IconButtonWidget(Icons.image_search, () async {
              var image = await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                bannerFile = File(image?.path ?? '');
              });
            })
          ],
        ),
        const TextWidget(
          text: "Banner: 700x100",
          style: Style.label,
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
                          )
                        : DropdownMenuWidget(widget.viewModel.socialMedias,
                            (item) {
                            isEditingSocialPlatform = true;
                            links[index].first?.platformId = item?.id ?? '';
                          },
                            current: widget.viewModel.socialMedias?.firstWhere(
                                (element) =>
                                    element?.id ==
                                    links[index].first?.platformId)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputTextWidget(
                          label: "Link",
                          icon: Icons.add_link,
                          controller: links[index].second,
                          validator: (value) {
                            isEditingSocialPlatform = true;
                            links[index].second?.text = value ?? '';
                            return null;
                          }),
                    ),
                    const BoundWidget(BoundType.small),
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.icon,
                        onPressed: () async {
                          isEditingSocialPlatform = true;
                          Clipboard.getData(Clipboard.kTextPlain).then((value) {
                            links[index].second?.text =
                                value?.text?.trim().replaceAll(' ', '') ?? '';
                          });
                        },
                        label: 'paste',
                        icon: Icons.paste),
                    const BoundWidget(BoundType.small),
                    ButtonWidget(
                        enabled: true,
                        type: ButtonType.icon,
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
        const BoundWidget(BoundType.huge),
        ButtonWidget(
            enabled: true,
            type: ButtonType.borderless,
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
      type: ButtonType.normal,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          List<int> bannerBytes = [];
          List<int> emblemBytes = [];
          List<LinkModel?> linksList = [];
          try {
            bannerBytes = bannerFile.readAsBytesSync();
          } catch (e) {}
          try {
            emblemBytes = emblemFile.readAsBytesSync();
          } catch (e) {}
          String bannerImage = base64Encode(bannerBytes);
          String emblem64Image = base64Encode(emblemBytes);
          for (var element in links) {
            element.first?.link = element.second?.text ?? '';
            linksList.add(element.first);
          }
          var league = LeagueModel(
              id: widget.viewModel.league?.id,
              owner: widget.viewModel.league?.owner,
              name: _nameController.text,
              description: _descriptionController.text,
              emblem: emblem64Image,
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
    widget.viewModel.setFlow(LeagueFlow.detail);
    return false;
  }
}
