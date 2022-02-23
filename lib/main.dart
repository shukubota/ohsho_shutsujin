import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ohsho_shutsujin/pages/form_example.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

void main() {
  runApp(ProviderScope(child: OhshoShutsujin()));
}

class OhshoShutsujin extends HookWidget {
  const OhshoShutsujin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text(text),
      ),
      body: Center(
        child: Panel(),
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
  static const String login = '/login';
  static const String formExample = '/form_example';
}

Map<String, WidgetBuilder> rootRouter = {
  Routes.splash: (BuildContext context) => const Home(text: 'home'),
  Routes.login: (BuildContext context) => const Login(),
  Routes.formExample: (BuildContext context) => FormExample(),
};

String initialRoute = Routes.formExample;

class TransitionType {
  TransitionType._();
  static const String fromRight = 'FROM_RIGHT';
  static const String fromLeft = 'FROM_LEFT';
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    new GlobalKey<NavigatorState>();
