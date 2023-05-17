import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/country_picker_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateView extends StatefulWidget {
  final ProfileViewModel viewModel;

  const ProfileUpdateView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _ProfileUpdateViewState createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surNameController = TextEditingController();
  late String password = "";
  late String? country = "BR";
  late String? picture = "";
  bool hasChanges = false;
  File bannerFile = File('');
  final ImagePicker _picker = ImagePicker();
  List<String> tags = [];

  @override
  void initState() {
    widget.viewModel.fetchProfile();
    _nameController.addListener(observers);
    _surNameController.addListener(observers);
    _nameController.text = widget.viewModel.profileModel?.firstName ?? '';
    _surNameController.text = widget.viewModel.profileModel?.surName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        bottom: buttonUpdateWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size128),
        pictureWidget(),
        const SpacingWidget(LayoutSize.size16),
        Form(
          child: profileForm(),
          key: _formKey,
        ),
        tagPickerWidget()
      ],
    );
  }

  Widget profileForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const SpacingWidget(LayoutSize.size16),
              InputTextWidget(
                  enabled: true,
                  label: 'Name',
                  icon: Icons.person,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty == true) {
                      return 'valid name needed';
                    }
                    return null;
                  }),
              const SpacingWidget(LayoutSize.size16),
              InputTextWidget(
                  enabled: true,
                  label: 'surName',
                  icon: Icons.person,
                  controller: _surNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty == true) {
                      return 'valid surName needed';
                    }
                    return null;
                  }),
              const SpacingWidget(LayoutSize.size16),
              CountryPickerWidget(
                country: widget.viewModel.profileModel?.country,
                onCountrySelected: (code) {
                  setState(() {
                    country = code;
                    hasChanges = hasAnyChange();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tagPickerWidget() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected = tags.contains(item?.id);
                    return ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: selected
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: selected ? const Text('-') : const Text('+'),
                        ),
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          setState(() {
                            selected
                                ? tags.remove(item?.id)
                                : tags.add(item?.id ?? '');
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
          );
  }

  Widget pictureWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48), // Image radius
                child: bannerFile.path.isEmpty
                    ? widget.viewModel.picture == null
                        ? Container()
                        : Image.memory(
                            base64Decode(widget.viewModel.picture?.image ?? ''),
                            fit: BoxFit.fill,
                          )
                    : Image.file(
                        bannerFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        ButtonWidget(
            type: ButtonType.icon,
            icon: Icons.add_a_photo,
            enabled: true,
            onPressed: () async {
              var image = await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                bannerFile = File(image?.path ?? '');
                widget.viewModel
                    .setPicture(base64Encode(bannerFile.readAsBytesSync()));
                hasChanges = true;
              });
            })
      ],
    );
  }

  Widget buttonUpdateWidget() {
    return ButtonWidget(
      enabled: hasChanges,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel.update(_nameController.text, _surNameController.text,
              country ?? '', base64Encode(bannerFile.readAsBytesSync()));
        }
      },
      label: "Update",
    );
  }

  bool hasAnyChange() {
    return widget.viewModel.profileModel?.firstName != _nameController.text ||
        widget.viewModel.profileModel?.surName != _surNameController.text ||
        widget.viewModel.profileModel?.country != country;
  }

  @override
  observers() {
    _nameController.addListener(() {
      setState(() {
        hasChanges = hasAnyChange();
      });
    });
    _surNameController.addListener(() {
      setState(() {
        hasChanges = hasAnyChange();
      });
    });
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
