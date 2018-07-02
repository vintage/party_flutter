import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
    const Color(0xFF678FB4),
    'assets/images/hotels.png',
    'Znajomi',
    'Zbierz grupkę znajomych i usiądźcie razem. Rozpoczyna najmłodszy gracz.',
    'assets/images/key.png',
  ),
  PageViewModel(
    const Color(0xFF65B0B4),
    'assets/images/banks.png',
    'Kategoria',
    'Wybierz z listy kategorię i przyłóż telefon do czoła. Odgaduj hasła na podstawie podpowiedzi swoich znajomych.',
    'assets/images/wallet.png',
  ),
  PageViewModel(
    const Color(0xFF9B90BC),
    'assets/images/stores.png',
    'Zabawa!',
    'Przechyl telefon do przodu jeśli odgadłeś, lub do tyłu aby przejść do następnego hasła. Powodzenia!',
    'assets/images/shopping_cart.png',
  ),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;
  final VoidCallback onSkip;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: viewModel.color,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Opacity(
          opacity: percentVisible,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  50.0 * (1.0 - percentVisible),
                  0.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Image.asset(
                    viewModel.heroAssetPath,
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  30.0 * (1.0 - percentVisible),
                  0.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    viewModel.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FlamanteRoma',
                      fontSize: 34.0,
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  30.0 * (1.0 - percentVisible),
                  0.0,
                ),
                child: Text(
                  viewModel.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  30.0 * (1.0 - percentVisible),
                  0.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 35.0, bottom: 75.0),
                  child: RaisedButton(
                    child: Text('Graj'),
                    onPressed: onSkip,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
  );
}
