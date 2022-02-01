import 'dart:io';

import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ChampionshipRacesModel {
  File posterFile;
  DateTime eventDate;
  ImagePicker picker;
  bool hasBroadcasting;
  List<SettingsModel?> settingsModel;
  TextEditingController titleController;
  TextEditingController notesController;
  TextEditingController broadcastingLinkController;
  List<Pair<TextEditingController, TextEditingController>> settingsControllers;

  ChampionshipRacesModel(
      {required this.hasBroadcasting,
      required this.eventDate,
      required this.settingsModel,
      required this.picker,
      required this.posterFile,
      required this.titleController,
      required this.notesController,
      required this.broadcastingLinkController,
      required this.settingsControllers});
}
