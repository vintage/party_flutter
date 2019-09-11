<p align="center">
  <img src="screenshots/logo.png?raw=true" alt="Party Flutter" />
</p>

# Party Flutter

[![Join the chat at https://gitter.im/party_flutter/community](https://badges.gitter.im/party_flutter/community.svg)](https://gitter.im/party_flutter/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![CircleCI](https://circleci.com/gh/vintage/party_flutter.svg?style=shield)](https://circleci.com/gh/vintage/party_flutter)

Mobile party game implemented in Flutter framework. Its been heavily inspired by the Heads Up! game:

- Get a group of friends (at least 3 players)
- Start the app
- The youngest player takes the phone
- Pick one of the available categories/topics (eg. Animals, TV series, Sport)
- Place the phone at your forehead, so that other players can see the screen
- Guess the word displayed at the screen - your friends are here to help you!

## Download

<div>
<a href='https://play.google.com/store/apps/details?id=com.puppybox.zgadula' target='_blank'><img alt='Get it on Google Play' src='screenshots/google_play.png' height='48px'/></a>
<a href='https://itunes.apple.com/us/app/zgadula-party-charades/id1181083547' target='_blank'><img alt='Get it on the App Store' src='screenshots/app_store.png' height='48px'/></a>
</div>

## Preview Video

[![Preview Video](https://img.youtube.com/vi/tAOXFdFt6SQ/0.jpg)](https://www.youtube.com/watch?v=tAOXFdFt6SQ)

## Screenshots

![Screen 1](/screenshots/screen1.png?raw=true "Screen #1")
![Screen 2](/screenshots/screen2.png?raw=true "Screen #2")
![Screen 3](/screenshots/screen3.png?raw=true "Screen #3")
![Screen 4](/screenshots/screen4.png?raw=true "Screen #4")
![Screen 5](/screenshots/screen5.png?raw=true "Screen #5")
![Screen 6](/screenshots/screen6.png?raw=true "Screen #6")
![Screen 7](/screenshots/screen7.png?raw=true "Screen #7")
![Screen 8](/screenshots/screen8.png?raw=true "Screen #8")

## Adding new language

1. Add language code to `getCodes` method in [language.dart](lib/services/language.dart)
2. Download language flag from [here](https://www.countryflags.com/en/image-overview/) and put it in [assets/images/flags/](assets/images/flags/)
3. Make a copy of file [intl_messages.arb](lib/l10n/intl_messages.arb) and translate the sentences (not the ones prefixed by `@`).
See the  [intl_messages_pl.arb](lib/l10n/intl_messages_pl.arb) for reference
4. When the translations are ready - run the `Generate translations` section
5. The UI is translated! The only remaining thing is to add own set of categories and questions
in [assets/data/](assets/data/). Each category consists of:

- id - unique identifier of category (just make sure it's unique across the file)
- image - image name for the category which is stored in [assets/images/categories/](assets/images/categories/).
Feel free to add your own images - should be non-transparent, 400x400, PNG files.
Can be downloaded from [https://www.pexels.com/](https://www.pexels.com/) or [https://unsplash.com/](https://unsplash.com/)
- name - category name in yours language
- questions - list of available questions - min. 50 per category, but more is better :)

6. Done, new language added - PRs are more than welcome ❤️

## Generate translations

- `flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations.dart`
- `flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localizations.dart lib/l10n/intl_*.arb`

## Resources

- [Icons](https://www.baianat.com/resources/thousands/)
