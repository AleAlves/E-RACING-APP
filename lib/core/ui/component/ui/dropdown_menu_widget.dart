import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  final String? hint;
  final SocialPlatformModel? current;
  final List<SocialPlatformModel?>? socialMedias;
  final ValueChanged<SocialPlatformModel?>? onSelected;

  const DropdownMenuWidget(this.socialMedias, this.onSelected,
      {this.current, this.hint, Key? key})
      : super(key: key);

  @override
  _DropdownMenuWidgetState createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.socialMedias!.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<SocialPlatformModel>(
              hint: TextWidget(text: widget.hint ?? '', style: Style.label),
              value: widget.current,
              underline: Container(height: 0),
              items: widget.socialMedias
                  ?.map<DropdownMenuItem<SocialPlatformModel>>((value) {
                return DropdownMenuItem<SocialPlatformModel>(
                  value: value,
                  child: TextWidget(text: value?.name ?? '',style: Style.label),
                );
              }).toList(),
              onChanged: (item) {
                setState(() {
                  widget.onSelected?.call(item);
                });
              },
            ),
          );
  }
}
