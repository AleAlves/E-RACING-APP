import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShortcutWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const ShortcutWidget({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 0.5, color: ERcaingApp.color)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ERcaingApp.color[10]),
        onPressed: () {},
        child: Center(
          child: SizedBox(
            width: 100,
            height: 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.settings, color: ERcaingApp.color),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      TextWidget(
                        "Configurar",
                        Style.description,
                        textColor: ERcaingApp.color,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
