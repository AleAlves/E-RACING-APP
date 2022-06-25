import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class ClassCollectionWidget extends StatefulWidget {
  final Function(ShortcutModel?) onPressed;
  final List<ClassesModel?>? classes;

  const ClassCollectionWidget(
      {required this.classes, required this.onPressed, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _ClassCollectionWidgetState createState() => _ClassCollectionWidgetState();
}

class _ClassCollectionWidgetState extends State<ClassCollectionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.drive_eta),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.classes == null
              ? Container()
              : Wrap(
                  spacing: 1.0,
                  runSpacing: 2.0,
                  children: widget.classes!
                      .map((tag) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
                              child: TextWidget(
                                  text: tag?.name ?? '', style: Style.caption),
                            ),
                          ),
                        );
                      })
                      .toList()
                      .cast<Widget>(),
                ),
        )
      ],
    );
  }
}
