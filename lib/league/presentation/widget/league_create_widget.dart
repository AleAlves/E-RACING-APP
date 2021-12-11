import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  File imageFile = File('');

  @override
  void initState() {
    _nameController.text = '';
    _descriptionController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(child: create(), key: _formKey),
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget create() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const TextWidget("Creating a league", Style.title),
          const BoundWidget(BoundType.huge),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.height / 2,
                  child: imageFile.path == ''
                      ? Image.asset(
                          'assets/default-banner.jpg',
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          imageFile,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              IconButtonWidget(Icons.image_search, () async {
                var image =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imageFile = File(image?.path ?? '');
                });
              })
            ],
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
          const BoundWidget(BoundType.huge),
          ButtonWidget("Concluir", ButtonType.normal, () {
            if (_formKey.currentState?.validate() == true) {
              List<int> imageBytes = imageFile.readAsBytesSync();
              String base64Image = base64Encode(imageBytes);
              widget.viewModel.create(_nameController.text,
                  _descriptionController.text, base64Image);
            }
          }),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LeagueFlow.list;
    return false;
  }
}
