import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';
import '../../navigation/event_create_flow.dart';

class EventCreateBannerView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateBannerView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateBannerViewState createState() => _EventCreateBannerViewState();
}

class _EventCreateBannerViewState extends State<EventCreateBannerView>
    implements BaseSateWidget {
  File bannerFile = File('');
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    observers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: buttonWidget(),
      scrollable: false,
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleWidget(),
          const SpacingWidget(LayoutSize.size48),
          bannerWidget()
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget titleWidget() {
    return const TextWidget(
        text: "What is the name of the event?", style: Style.subtitle);
  }

  Widget bannerWidget() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.height,
                child: bannerFile.path == ''
                    ? Container()
                    : Image.file(
                        bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            ButtonWidget(
                enabled: true,
                type: ButtonType.iconButton,
                icon: Icons.image_search,
                onPressed: () async {
                  var image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    bannerFile = File(image?.path ?? '');
                  });
                })
          ],
        ),
        const SpacingWidget(LayoutSize.size32),
        const TextWidget(
          text: "Banner: 1000x1000",
          style: Style.paragraph,
          align: TextAlign.start,
        ),
      ],
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: bannerFile.path.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.onNavigate(EventCreateNavigator.classes);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(EventCreateNavigator.score);
    return false;
  }
}
