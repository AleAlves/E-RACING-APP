import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';


class DropdownMenuWidget extends StatefulWidget {
  final String? hint;
  final List<SocialPlatformModel?>? socialMedias;
  final ValueChanged<SocialPlatformModel?>? onSelected;

  const DropdownMenuWidget(this.socialMedias, this.hint, this.onSelected,
      {Key? key}) : super(key: key);

  @override
  _DropdownMenuWidgetState createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {

  late SocialPlatformModel? curent;

  @override
  void initState() {
    super.initState();
    curent = widget.socialMedias?[0];
  }

  @override
  Widget build(BuildContext context) {
    return widget.socialMedias!.isEmpty
        ? Container()
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<SocialPlatformModel>(
        hint: TextWidget(widget.hint ?? '', Style.label),
        value: curent,
        underline: Container(height: 0),
        items: widget.socialMedias
            ?.map<DropdownMenuItem<SocialPlatformModel>>((value) {
          return DropdownMenuItem<SocialPlatformModel>(
            value: value,
            child: TextWidget(value?.name ?? '', Style.label),
          );
        }).toList(),
        onChanged: (item) {
          setState(() {
            curent = item;
            widget.onSelected?.call(item);
          });
        },
      ),
    );
  }
}
