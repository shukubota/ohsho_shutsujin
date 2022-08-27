import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ohsho_shutsujin/pages/form_example.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

void main() {
  runApp(const ProviderScope(child: OhshoShutsujin()));
}

class OhshoShutsujin extends HookConsumerWidget {
  const OhshoShutsujin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '王将出陣',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (RouteSettings settings) {
        print('build ${settings.name}');
        WidgetBuilder builder = rootRouter[settings.name] as WidgetBuilder;
        return MaterialPageRoute(
          builder: (ctx) => builder(ctx),
          settings: settings,
        );
      },
      navigatorKey: rootNavigatorKey,
    );
  }
}

class Home extends HookWidget {
  final String text;
  const Home({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(text),
      // ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                "王将出陣",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "王将をゴールまで移動させましょう！",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                "ゴール",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              child: const Text(
                "↑↑↑↑↑↑",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Panel(),
          ],
        ),
      ),
    );
  }
}

class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('path1'),
      ),
      body: Center(
        child: Text('path1'),
      ),
    );
  }
}

class Routes {
  Routes._();
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String formExample = '/form_example';
}

Map<String, WidgetBuilder> rootRouter = {
  Routes.splash: (BuildContext context) => const Home(text: 'home'),
  Routes.home: (BuildContext context) => const Home(text: 'home'),
  Routes.login: (BuildContext context) => const Login(),
  Routes.formExample: (BuildContext context) => FormExample(),
};

String initialRoute = Routes.splash;

class TransitionType {
  TransitionType._();
  static const String fromRight = 'FROM_RIGHT';
  static const String fromLeft = 'FROM_LEFT';
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    new GlobalKey<NavigatorState>();
