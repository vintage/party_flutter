import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/services/language.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/store/language.dart';
import '../shared/widgets.dart';

class SettingsScreen extends StatelessWidget {
  Future<bool> _requestPermissions(
      List<PermissionGroup> permissionGroups) async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions(permissionGroups);

    return permissions.values
        .where((status) => status != PermissionStatus.granted)
        .isEmpty;
  }

  Future<bool> requestCameraPermissions() async {
    return _requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.microphone,
    ]);
  }

//  Future<bool> requestSpeechPermissions() async {
//    return _requestPermissions([
//      PermissionGroup.speech,
//      PermissionGroup.microphone,
//    ]);
//  }

  void logChange(String field, dynamic value) {
    AnalyticsService.logEvent(field, {"value": value});
  }

  Widget buildContent(context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: ScopedModelDescendant<SettingsModel>(
        builder: (context, child, model) {
          return Column(
            children: <Widget>[
              SwitchListTile(
                title: Text(AppLocalizations.of(context).settingsCamera),
                subtitle: Text(AppLocalizations.of(context).settingsCameraHint),
                value: model.isCameraEnabled,
                onChanged: (bool value) async {
                  if (value && !await requestCameraPermissions()) {
                    return;
                  }

                  logChange('settings_camera', value);
                  model.toggleCamera();
                },
                secondary: Icon(Icons.camera_alt),
              ),
//              SwitchListTile(
//                title: Text(AppLocalizations.of(context).settingsSpeech),
//                subtitle: Text(AppLocalizations.of(context).settingsSpeechHint),
//                value: model.isSpeechEnabled,
//                onChanged: (bool value) async {
//                  if (value && !await requestSpeechPermissions()) {
//                    return;
//                  }
//
//                  model.toggleSpeech();
//                },
//                secondary: Icon(Icons.mic),
//              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context).settingsAccelerometer),
                subtitle: Text(
                    AppLocalizations.of(context).settingsAccelerometerHint),
                value: model.isRotationControlEnabled,
                onChanged: (bool value) {
                  logChange('settings_accelerometer', value);
                  model.toggleRotationControl();
                },
                secondary: Icon(Icons.screen_rotation),
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context).settingsAudio),
                value: model.isAudioEnabled,
                onChanged: (bool value) {
                  logChange('settings_audio', value);
                  model.toggleAudio();
                },
                secondary: Icon(Icons.music_note),
              ),
              ScopedModelDescendant<LanguageModel>(
                builder: (context, child, model) {
                  return ListTile(
                    title: Text(AppLocalizations.of(context).settingsLanguage),
                    leading: Icon(Icons.flag),
                    trailing: DropdownButton(
                      value: model.language,
                      items: LanguageService.getCodes()
                          .map(
                            (code) => DropdownMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: FlagImage(country: code),
                                  ),
                                  Text(code.toUpperCase()),
                                ],
                              ),
                              value: code,
                            ),
                          )
                          .toList(),
                      onChanged: (String language) {
                        logChange('settings_language', language);
                        model.changeLanguage(language);
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.open_in_browser),
                title: Text(AppLocalizations.of(context).settingsPrivacyPolicy),
                onTap: openPrivacyPolicy,
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(AppLocalizations.of(context).settingsStartTutorial),
                onTap: () => openTutorial(context),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  buildContent(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openTutorial(BuildContext context) {
    AnalyticsService.logEvent('settings_tutorial', {});
    Navigator.pushNamed(
      context,
      '/tutorial',
    );
  }

  openCredits(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/contributors',
    );
  }

  openPrivacyPolicy() async {
    AnalyticsService.logEvent('settings_privacy', {});

    const url = SettingsModel.privacyPolicyUrl;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
