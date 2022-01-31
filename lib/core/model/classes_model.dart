import 'package:json_annotation/json_annotation.dart';

import 'entry_model.dart';

part 'classes_model.g.dart';

@JsonSerializable()
class ClassesModel {
  String? name;
  int? maxEntries;
  List<EntryModel?>? entries;
  List<String?>? attenders;

  ClassesModel(
      {required this.name, this.maxEntries, this.attenders, this.entries});

  factory ClassesModel.fromJson(Map<String, dynamic> json) =>
      _$ClassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClassesModelToJson(this);
}
