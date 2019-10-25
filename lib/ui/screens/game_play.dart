import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pedantic/pedantic.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/services/audio.dart';
import 'package:zgadula/services/vibration.dart';
import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/models/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/store/gallery.dart';
import 'package:zgadula/ui/screens/camera_preview.dart';
import 'package:zgadula/ui/templates/screen.dart';
import 'package:zgadula/ui/theme.dart';
import 'package:zgadula/services/pictures.dart';
import 'package:zgadula/services/ads.dart';
import '../shared/widgets.dart';

class GamePlayScreen extends StatefulWidget {
  GamePlayScreen({Key key}) : super(key: key);

  @override
  GamePlayScreenState createState() => GamePlayScreenState();
}

class GamePlayScreenState extends State<GamePlayScreen>
    with TickerProviderStateMixin {
  static const _rotationChannel = MethodChannel('zgadula/orientation');
  static const backgroundOpacity = 0.9;

  Timer gameTimer;
  int secondsMax;
  int secondsLeft = 5;
  bool isStarted = false;
  bool isPaused = false;
  bool isCameraEnabled = false;
  bool showAd = false;
  StreamSubscription<dynamic> _rotateSubscription;
  Category category;

  AnimationController invalidAC;
  Animation<double> invalidAnimation;
  AnimationController validAC;
  Animation<double> validAnimation;

  @override
  void initState() {
    super.initState();
    startTimer();
    category = CategoryModel.of(context).currentCategory;
    QuestionModel.of(context).generateCurrentQuestions(category.id);

    SettingsModel settings = SettingsModel.of(context);
    secondsMax = settings.roundTime;
    isCameraEnabled = settings.isCameraEnabled;
    if (settings.isRotationControlEnabled) {
      enableRotationControl();
    }
    var gamesCount = settings.gamesFinished + 1;
    showAd = gamesCount % 2 == 0;
    if (showAd) {
      AdsService.loadInterstitialAd();
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    // TODO: Remove it when fixed in Flutter
    // https://github.com/flutter/flutter/issues/13238
    try {
      _rotationChannel.invokeMethod('setLandscape');
    } catch (error) {
      print("Error on landscape");
    }

    initAnimations();

    AnalyticsService.logEvent('play_game', {'category': category.name});
  }

  AnimationController createAnswerAnimationController() {
    const duration = Duration(milliseconds: 1500);
    var controller = AnimationController(vsync: this, duration: duration);
    controller
      ..addStatusListener((listener) {
        if (listener == AnimationStatus.completed) {
          controller.reset();
          nextQuestion();
        }
      });

    return controller;
  }

  initAnimations() {
    invalidAC = createAnswerAnimationController();
    invalidAnimation =
        CurvedAnimation(parent: invalidAC, curve: Curves.elasticOut);

    validAC = createAnswerAnimationController();
    validAnimation = CurvedAnimation(parent: validAC, curve: Curves.elasticOut);
  }

  @protected
  @mustCallSuper
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // TODO: Remove it when fixed in Flutter
    // https://github.com/flutter/flutter/issues/13238
    try {
      _rotationChannel.invokeMethod('setPortrait');
    } catch (error) {
      print("Error on portrait");
    }

    if (_rotateSubscription != null) {
      _rotateSubscription.cancel();
    }

    validAC?.dispose();
    invalidAC?.dispose();

    super.dispose();
    stopTimer();
  }

  enableRotationControl() {
    bool safePosition = true;
    double rotationBorder = 9.5;

    _rotateSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if (!isStarted || isPaused) {
        return;
      }

      if (event.z > rotationBorder) {
        if (safePosition) {
          safePosition = false;
          handleInvalid();
        }
      } else if (event.z < -rotationBorder) {
        if (safePosition) {
          safePosition = false;
          handleValid();
        }
      } else if (event.z.abs() > rotationBorder / 2) {
        safePosition = true;
      }
    });
  }

  startTimer() {
    gameTimer = Timer.periodic(const Duration(seconds: 1), gameLoop);
  }

  stopTimer() {
    gameTimer?.cancel();
  }

  void gameLoop(Timer timer) {
    if (isPaused) {
      return;
    }

    if (secondsLeft <= 0 && !isPaused) {
      return handleTimeout();
    }

    setState(() {
      secondsLeft -= 1;
    });
  }

  savePictures() async {
    GalleryModel.of(context).update(await PicturesService.getFiles(context));
  }

  showScore() {
    SettingsModel.of(context).increaseGamesFinished();
    CategoryModel.of(context).increasePlayedCount(category);
    AnalyticsService.logEvent('game_score', {
      'valid': QuestionModel.of(context).questionsPassed.length,
      'invalid': QuestionModel.of(context).questionsFailed.length,
    });
    Navigator.pushReplacementNamed(context, '/game-summary');
    AdsService.showInterstitialAd();
  }

  Future<bool> confirmBack() async {
    Completer completer = Completer<bool>();

    unawaited(
      Alert(
        context: context,
        type: AlertType.warning,
        title: 'Zgadula',
        style: AlertStyle(
          isCloseButton: false,
          isOverlayTapDismiss: false,
          alertBorder: Border(),
          titleStyle: TextStyle(color: Colors.white),
          descStyle: TextStyle(color: Colors.white, height: 1.05),
          buttonAreaPadding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
        ),
        desc: AppLocalizations.of(context).gameCancelConfirmation,
        buttons: [
          DialogButton(
            child: Text(AppLocalizations.of(context).gameCancelDeny),
            onPressed: () {
              Navigator.pop(context);
              completer.complete(false);
            },
            color: Colors.transparent,
          ),
          DialogButton(
            child: Text(AppLocalizations.of(context).gameCancelApprove),
            onPressed: () {
              Navigator.pop(context);
              completer.complete(true);
            },
            color: Theme.of(context).accentColor,
          ),
        ],
      ).show(),
    );

    return completer.future;
  }

  void gameOver() {
    savePictures();
    showScore();
  }

  nextQuestion() {
    stopTimer();
    if (secondsLeft == 0) {
      return gameOver();
    }

    QuestionModel.of(context).setNextQuestion();
    if (QuestionModel.of(context).currentQuestion == null) {
      return gameOver();
    }

    setState(() {
      isPaused = false;
    });

    startTimer();
  }

  postAnswer({@required bool isValid}) {
    VibrationService.vibrate();
    QuestionModel.of(context).answerQuestion(isValid);

    setState(() {
      isPaused = true;
    });

    AnalyticsService.logEvent('answer_question', {
      'valid': isValid,
      'question': QuestionModel.of(context).currentQuestion.name,
      'category': category.name,
    });
  }

  handleValid() {
    if (isPaused) {
      return;
    }

    AudioService.valid(context);
    validAC.forward();
    postAnswer(isValid: true);
  }

  handleInvalid() {
    if (isPaused) {
      return;
    }

    AudioService.invalid(context);
    invalidAC.forward();
    postAnswer(isValid: false);
  }

  void handleTimeout() {
    if (isStarted) {
      handleInvalid();
    } else {
      setState(() {
        isStarted = true;
        secondsLeft = secondsMax;
      });
    }
  }

  Widget buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 64.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildHeaderIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Icon(
        icon,
        size: ThemeConfig.fullScreenIconSize,
        color: Theme.of(context).textTheme.body1.color,
      ),
    );
  }

  Widget buildSplashContent(Widget child, Color background, [IconData icon]) {
    return Container(
      decoration: BoxDecoration(color: background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: child,
            ),
          ),
          QuestionModel.of(context).isPreLastQuestion()
              ? Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    AppLocalizations.of(context).lastQuestion,
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ].where((o) => o != null).toList(),
      ),
    );
  }

  Widget buildGameContent() {
    return ScopedModelDescendant<QuestionModel>(
      builder: (context, child, model) {
        var currentQuestion = model.currentQuestion;

        return Stack(
          children: [
            Row(
              children: [
                GameController(
                  child: buildHeaderIcon(Icons.sentiment_very_satisfied),
                  alignment: Alignment.bottomCenter,
                  color: successColor.withOpacity(backgroundOpacity),
                  onTap: handleValid,
                ),
                GameController(
                  child: buildHeaderIcon(Icons.sentiment_very_dissatisfied),
                  alignment: Alignment.bottomCenter,
                  color: Theme.of(context)
                      .errorColor
                      .withOpacity(backgroundOpacity),
                  onTap: handleInvalid,
                ),
              ],
            ),
            IgnorePointer(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    currentQuestion == null
                        ? null
                        : Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SafeArea(
                              child: Text(
                                currentQuestion.categoryName,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    currentQuestion == null
                        ? null
                        : Expanded(
                            child: Center(
                              child: buildHeader(currentQuestion.name),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        secondsLeft.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ].where((o) => o != null).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildContent() {
    if (isPaused || isStarted) {
      return Stack(
        children: [
          buildGameContent(),
          ScaleTransition(
            scale: invalidAnimation,
            child: buildSplashContent(
              buildHeaderIcon(Icons.sentiment_very_dissatisfied),
              Theme.of(context).errorColor,
            ),
          ),
          ScaleTransition(
            scale: validAnimation,
            child: buildSplashContent(
              buildHeaderIcon(Icons.sentiment_very_satisfied),
              successColor,
            ),
          ),
        ],
      );
    }

    return buildSplashContent(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              AppLocalizations.of(context).preparationOrientationDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          buildHeader(secondsLeft.toString()),
        ],
      ),
      Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showCamera = isCameraEnabled && isStarted;

    return ScreenTemplate(
      onBack: () async {
        if (await confirmBack()) {
          Navigator.pop(context);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return await confirmBack();
        },
        child: Stack(
          children: [
            showCamera ? CameraPreviewScreen() : null,
            buildContent(),
          ].where((o) => o != null).toList(),
        ),
      ),
    );
  }
}
