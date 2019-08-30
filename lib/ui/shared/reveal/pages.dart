import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(color: viewModel.color),
      width: double.infinity,
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
                    height: 1.2,
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
                  padding: const EdgeInsets.only(top: 35.0, bottom: 75.0),
                  child: RaisedButton.icon(
                    label: Text(viewModel.skip),
                    icon: Icon(Icons.play_circle_outline),
                    onPressed: onSkip,
                  ),
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
  final String skip;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.skip,
  );
}
