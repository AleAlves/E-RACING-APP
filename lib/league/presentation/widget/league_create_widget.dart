import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';
import '../league_view_model.dart';

class LeagueCreateWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueCreateWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateWidgetState createState() => _LeagueCreateWidgetState();
}

class _LeagueCreateWidgetState extends State<LeagueCreateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File bannerFile = File('');
  File emblemFile = File('');
  List<String?> tags = [];

  @override
  void initState() {
    _nameController.text = '';
    _descriptionController.text = '';
    if (widget.viewModel.tags?.isEmpty == true) {
      widget.viewModel.fetchTags();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(builder: (_) {
          return Form(child: create(), key: _formKey);
        }),
        onWillPop: _onBackPressed);
  }

  Widget create() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                      ? Container(
                    color: ERcaingApp.color[20],
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
          const BoundWidget(BoundType.small),
          const TextWidget(
            "Emblem: 100x100",
            Style.label,
            align: TextAlign.start,
          ),
          const BoundWidget(BoundType.medium),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: SizedBox(
                  height: 100,
                  width: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: bannerFile.path == ''
                      ? Container(
                    color: ERcaingApp.color[20],
                  )
                      : Image.file(
                    bannerFile,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              IconButtonWidget(Icons.image_search, () async {
                var image =
                await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  bannerFile = File(image?.path ?? '');
                });
              })
            ],
          ),
          const BoundWidget(BoundType.small),
          const TextWidget(
            "Banner: 700x100",
            Style.label,
            align: TextAlign.start,
          ),
          const BoundWidget(BoundType.medium),
          TextFormWidget("Nome", Icons.title, _nameController, (value) {
            if (value == null || value.isEmpty == true) {
              return 'Name needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          TextFormWidget("Descrição", Icons.title, _descriptionController,
                  (value) {
                if (value == null || value.isEmpty == true) {
                  return 'Name needed';
                }
                return null;
              }),
          const BoundWidget(BoundType.medium),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 35.0,
              maxHeight: 160.0,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.viewModel.tags?.length,
              itemBuilder: (context, index) {
                final selected = tags.contains(
                    widget.viewModel.tags?[index]?.id);
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ActionChip(
                      avatar: CircleAvatar(
                        backgroundColor: ERcaingApp.color,
                        child:
                        selected
                            ? const Text('-')
                            : const Text('+'),
                      ),
                      label: Text(widget.viewModel.tags?[index]?.name ?? ''),
                      onPressed: () {
                        setState(() {
                          selected ?
                          tags.remove(widget.viewModel.tags?[index]?.id):
                          tags.add(widget.viewModel.tags?[index]?.id);
                        });
                      })
                  ,
                );
              },
            )
          ),
          const BoundWidget(BoundType.huge),
          ButtonWidget("Concluir", ButtonType.normal, () {
            if (_formKey.currentState?.validate() == true) {
              List<int> imageBytes = [];
              List<int> emblemBytes= [];
              try{
                imageBytes = bannerFile.readAsBytesSync();
                emblemBytes = emblemFile.readAsBytesSync();
              }catch(e){}
              String bannerImage = base64Encode(imageBytes);
              String emblem64Image = base64Encode(emblemBytes);
              widget.viewModel.create(_nameController.text,
                  _descriptionController.text, bannerImage, emblem64Image, tags);
            }
          }),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
