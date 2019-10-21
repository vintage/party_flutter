import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zgadula/services/language.dart';

import 'l10n/messages_all.dart' show initializeMessages;

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get tutorialSkip {
    return Intl.message(
      'Play',
      name: 'tutorialSkip',
      desc: 'Button which skips the tutorial and takes the player to the game',
    );
  }

  String get tutorialFirstSectionHeader {
    return Intl.message(
      'Friends',
      name: 'tutorialFirstSectionHeader',
      desc: 'Header for the first tutorial section',
    );
  }

  String get tutorialFirstSectionDescription {
    return Intl.message(
      'Gather a groups of friends and sit together. Youngest player starts.',
      name: 'tutorialFirstSectionDescription',
      desc: 'Description for the first tutorial section',
    );
  }

  String get tutorialSecondSectionHeader {
    return Intl.message(
      'Category',
      name: 'tutorialSecondSectionHeader',
      desc: 'Header for the second tutorial section',
    );
  }

  String get tutorialSecondSectionDescription {
    return Intl.message(
      'Select the category and place the phone on forehead. Guess the word with friends help.',
      name: 'tutorialSecondSectionDescription',
      desc: 'Description for the second tutorial section',
    );
  }

  String get tutorialThirdSectionHeader {
    return Intl.message(
      'Tips',
      name: 'tutorialThirdSectionHeader',
      desc: 'Header for the third tutorial section',
    );
  }

  String get tutorialThirdSectionDescription {
    return Intl.message(
      'Decide on what kind of tips would you use during the round - speak, show, draw or even hum.',
      name: 'tutorialThirdSectionDescription',
      desc: 'Description for the third tutorial section',
    );
  }

  String get tutorialFourthSectionHeader {
    return Intl.message(
      'Fun!',
      name: 'tutorialFourthSectionHeader',
      desc: 'Header for the fourth tutorial section',
    );
  }

  String get tutorialFourthSectionDescription {
    return Intl.message(
      'Tap the screen for next question. Good luck!',
      name: 'tutorialFourthSectionDescription',
      desc: 'Description for the fourth tutorial section',
    );
  }

  String get preparationPlay {
    return Intl.message(
      'Play',
      name: 'preparationPlay',
      desc:
          'Button which confirms the selected category and starts the main game',
    );
  }

  String get preparationOrientationDescription {
    return Intl.message(
      'Place the phone on forehead',
      name: 'preparationOrientationDescription',
      desc:
          'Message which reminds player to put the phone in landscape orientation before game starts',
    );
  }

  String get gameCancelConfirmation {
    return Intl.message(
      'Do you want to cancel the current game?',
      name: 'gameCancelConfirmation',
      desc:
          'Description of the dialog which is presented to the player when he tries to quit the game loop',
    );
  }

  String get gameCancelApprove {
    return Intl.message(
      'OK',
      name: 'gameCancelApprove',
      desc: 'Text for approving the decision to cancel current game.',
    );
  }

  String get gameCancelDeny {
    return Intl.message(
      'Cancel',
      name: 'gameCancelDeny',
      desc: 'Text for canceling the decision to cancel current game.',
    );
  }

  String get lastQuestion {
    return Intl.message(
      'Last Question',
      name: 'lastQuestion',
      desc: 'Text shown before presenting last question during the game',
    );
  }

  String get summaryHeader {
    return Intl.message(
      'Your score',
      name: 'summaryHeader',
      desc:
          'Header displayed at the top of summary screen, informing player about current score',
    );
  }

  String get summaryBack {
    return Intl.message(
      'Play again',
      name: 'summaryBack',
      desc:
          'Button which takes the player from summary screen to category listing',
    );
  }

  String get settingsHeader {
    return Intl.message(
      'Settings',
      name: 'settingsHeader',
      desc: 'Header displayed at the top of settings screen',
    );
  }

  String get settingsCamera {
    return Intl.message(
      'Camera',
      name: 'settingsCamera',
      desc: 'Label for toggling camera support',
    );
  }

  String get settingsCameraHint {
    return Intl.message(
      'Take temporary photos during game',
      name: 'settingsCameraHint',
      desc: 'Hint for toggling camera support',
    );
  }

  String get settingsSpeech {
    return Intl.message(
      'Microphone',
      name: 'settingsSpeech',
      desc: 'Label for toggling speech recognition support',
    );
  }

  String get settingsSpeechHint {
    return Intl.message(
      'Recognize answers automatically during game',
      name: 'settingsSpeechHint',
      desc: 'Hint for toggling speech recognition support',
    );
  }

  String get settingsAccelerometer {
    return Intl.message(
      'Accelerometer',
      name: 'settingsAccelerometer',
      desc: 'Label for toggling accelerometer support',
    );
  }

  String get settingsAccelerometerHint {
    return Intl.message(
      'Tilt the phone down if you guess the word correctly',
      name: 'settingsAccelerometerHint',
      desc: 'Hint for toggling accelerometer support',
    );
  }

  String get settingsAudio {
    return Intl.message(
      'Audio',
      name: 'settingsAudio',
      desc: 'Label for toggling audio support',
    );
  }

  String get settingsLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguage',
      desc: 'Label for changing game language',
    );
  }

  String get settingsPrivacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'settingsPrivacyPolicy',
      desc: 'Label for opening privacy policy',
    );
  }

  String get settingsStartTutorial {
    return Intl.message(
      'How to play?',
      name: 'settingsStartTutorial',
      desc: 'Label for opening tutorial',
    );
  }

  String get gameTime {
    return Intl.message(
      'Game time',
      name: 'gameTime',
      desc: 'Label for game time slider',
    );
  }

  String categoryItemQuestionsCount(int count) {
    return Intl.message(
      "$count items",
      name: "categoryItemQuestionsCount",
      args: [count],
      desc: "Metadata showing total count of questions in category",
    );
  }

  String get emptyFavorites {
    return Intl.message(
      'Add favorite categories to find them quicker',
      name: 'emptyFavorites',
      desc: 'Hint shown when there are no favorites defined',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LanguageService.getCodes().contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class SettingsLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  const SettingsLocalizationsDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(SettingsLocalizationsDelegate old) => true;
}
