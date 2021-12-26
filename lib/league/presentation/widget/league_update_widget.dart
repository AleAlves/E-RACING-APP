import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/link_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/dropdown_menu_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';
import '../league_view_model.dart';

class LeagueUpdateWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueUpdateWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueUpdateWidgetState createState() => _LeagueUpdateWidgetState();
}

class _LeagueUpdateWidgetState extends State<LeagueUpdateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  int _index = 0;
  File bannerFile = File('');
  File emblemFile = File('');
  List<String?> tags = [];
  List<TextEditingController> socialPlatformsControllers = [];
  List<LinkModel?> socialPlatforms = [];
  bool isEditingTags = false;
  bool isEditingEmblem = false;
  bool isEditingBanner = false;
  bool isEditingSocialPlatform = false;

  @override
  void initState() {
    widget.viewModel.getLeague();
    widget.viewModel.fetchSocialMedias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ViewStateWidget(content(), widget.viewModel.state);
    });
  }

  Widget content() {
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

    return Form(
      child: updateForm(),
      key: _formKey,
    );
  }

  Widget updateForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Column(
          children: [
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
      ),
    );
  }

  Widget basic() {
    return Column(
      children: [
        const BoundWidget(BoundType.huge),
        TextFormWidget("Nome", Icons.title, _nameController, (value) {
          if (value == null || value.isEmpty == true) {
            return 'Name needed';
          }
          return null;
        }),
        const BoundWidget(BoundType.huge),
        TextFormWidget("Descrição", Icons.title, _descriptionController,
            (value) {
          if (value == null || value.isEmpty == true) {
            return 'Name needed';
          }
          return null;
        }),
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
                        backgroundColor:
                            selected ? ERcaingApp.color[400] : ERcaingApp.color,
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
                    child: emblemFile.path == ''
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
              "Emblem: 100x100",
              Style.label,
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
          "Banner: 700x100",
          Style.label,
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
          itemCount: socialPlatforms.length,
          itemBuilder: (context, index) {
            socialPlatformsControllers.add(TextEditingController());
            return Column(
              children: [
                Row(
                  children: [
                    DropdownMenuWidget(
                        widget.viewModel.socialMedias, "Platform", (item) {
                      socialPlatforms[index] = LinkModel(
                          item?.id, socialPlatformsControllers[index].text);
                    }),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormWidget("Link", Icons.add_link,
                          socialPlatformsControllers[index], (value) {
                        socialPlatforms[index] = LinkModel(
                            widget.viewModel.socialMedias?[index]?.id ?? '',
                            socialPlatformsControllers[index].text);
                        return null;
                      }),
                    ),
                    const BoundWidget(BoundType.small),
                    ButtonWidget(ButtonType.icon, () async {
                      Clipboard.getData(Clipboard.kTextPlain).then((value) {
                        socialPlatformsControllers[index].text =
                            value?.text?.trim().replaceAll(' ', '') ?? '';
                      });
                    }, label: 'paste', icon: Icons.paste),
                    const BoundWidget(BoundType.small),
                    ButtonWidget(ButtonType.icon, () async {
                      setState(() {
                        socialPlatforms.removeAt(index);
                        socialPlatformsControllers.removeAt(index);
                      });
                    }, label: 'delete', icon: Icons.delete),
                  ],
                ),
              ],
            );
          },
        ),
        const BoundWidget(BoundType.huge),
        ButtonWidget(ButtonType.borderless, () async {
          setState(() {
            socialPlatforms.add(LinkModel('', ''));
          });
        }, label: 'New link'),
      ],
    );
  }

  Widget terms() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: false,
          onChanged: (bool? value) {
            setState(() {});
          },
        ),
        const TextWidget("I read and accept the terms", Style.label)
      ],
    );
  }

  Widget finish() {
    return ButtonWidget(
      ButtonType.normal,
      () {
        if (_formKey.currentState?.validate() == true) {
          List<int> imageBytes = [];
          List<int> emblemBytes = [];
          try {
            imageBytes = bannerFile.readAsBytesSync();
            emblemBytes = emblemFile.readAsBytesSync();
          } catch (e) {}
          String bannerImage = base64Encode(imageBytes);
          String emblem64Image = base64Encode(emblemBytes);
          var league = LeagueModel(
              id: widget.viewModel.league?.id,
              owner: widget.viewModel.league?.owner,
              name: _nameController.text,
              description: _descriptionController.text,
              emblem: emblem64Image,
              capacity: widget.viewModel.league?.capacity,
              members: widget.viewModel.league?.members,
              tags: widget.viewModel.league?.tags);
          var media = MediaModel(bannerImage, origin: league.id);
          widget.viewModel.update(league, media);
        }
      },
      label: "Update",
    );
  }
}
