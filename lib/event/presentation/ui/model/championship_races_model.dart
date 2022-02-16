import 'dart:io';

import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ChampionshipRacesModel {
  File posterFile;
  DateTime eventDate;
  ImagePicker picker;
  bool hasBroadcasting;
  List<SessionModel>? sessions;
  TextEditingController titleController;
  TextEditingController broadcastingLinkController;

  ChampionshipRacesModel(
      {required this.hasBroadcasting,
      required this.eventDate,
      required this.sessions,
      required this.picker,
      required this.posterFile,
      required this.titleController,
      required this.broadcastingLinkController});
}
