<p align="center">
  <img src="screens/logo.png?raw=true" alt="Party Flutter" />
</p>

# Party Flutter

Mobile party game implemented in Flutter framework. Its been heavily inspired by the Heads Up! game:

- Get a group of friends (at least 3 players)
- Start the app
- The youngest player takes the phone
- Pick one of the available categories/topics (eg. Animals, TV series, Sport)
- Place the phone at your forehead, so that other players can see the screen
- Guess the word displayed at the screen - your friends are here to help you!


## Stores

The existing production version has been implemented in hybrid technologies and you can check it out at:

 - [Google Play](https://play.google.com/store/apps/details?id=com.puppybox.zgadula)
 - [App Store](https://itunes.apple.com/pl/app/zgadula/id1181083547?l=pl&mt=8)

Just a note - it's only available in Polish language.
The current repository is an approach to rewrite it fully in Flutter and enable much more languages.


## Screenshots

![Screen 1](/screens/screen1.png?raw=true "Screen #1")
![Screen 2](/screens/screen2.png?raw=true "Screen #2")
![Screen 3](/screens/screen3.png?raw=true "Screen #3")
![Screen 4](/screens/screen4.png?raw=true "Screen #4")
![Screen 5](/screens/screen5.png?raw=true "Screen #5")
![Screen 6](/screens/screen6.png?raw=true "Screen #6")
![Screen 7](/screens/screen7.png?raw=true "Screen #7")
![Screen 8](/screens/screen8.png?raw=true "Screen #8")

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


## TODO

- More animations (opening next question during game loop)
- More languages
- Splash screen image
- Configure Firebase Crashlytics
