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

Just a note - it's only available in Polish language. The current repository is an approach to rewrite it fully in Flutter.


## Screenshots

![Screen 1](/screens/screen1.png?raw=true "Screen #1")
![Screen 2](/screens/screen2.png?raw=true "Screen #2")
![Screen 3](/screens/screen3.png?raw=true "Screen #3")
![Screen 4](/screens/screen4.png?raw=true "Screen #4")
![Screen 5](/screens/screen5.png?raw=true "Screen #5")
![Screen 6](/screens/screen6.png?raw=true "Screen #6")
![Screen 7](/screens/screen7.png?raw=true "Screen #7")

## Generate translations

- `flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations.dart`
- `flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localizations.dart lib/l10n/intl_*.arb`


## TODO

- Improve the UI
- Organize the code
- Translations (for the UI)
- Translations (for content)
- More animations
- A lot more


## Version
0.0.1
