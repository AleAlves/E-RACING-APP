import 'dart:io';
import 'dart:typed_data';

import 'package:e_racing_app/core/model/session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ChampionshipRacesModel {
  File? posterFile;
  Uint8List? posterbase64;
  DateTime? eventDate;
  ImagePicker? picker;
  bool? hasBroadcasting;
  List<SessionModel?>? sessions;
  TextEditingController? titleController;
  TextEditingController? broadcastingLinkController;

  ChampionshipRacesModel({
    required this.hasBroadcasting,
    required this.eventDate,
    required this.sessions,
    required this.picker,
    required this.posterFile,
    required this.titleController,
    required this.broadcastingLinkController,
    this.posterbase64,
  });
}
