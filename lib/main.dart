import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ohsho_shutsujin/pages/form_example.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print(message);
  print("==background");

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("--------------aaa");
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  print('token');
  final url = Uri.parse('https://hooks.slack.com/services/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');
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({'text': fcmToken});
  final response = await http.post(url, headers: headers, body: body);

  print(response.body);
  print(response.statusCode);

  // curl -X POST -H 'Content-type: application/json' --data '{"text":"Hello, World!"}' https://hooks.slack.com/services/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

  // this.senderId,
  // this.category,
  // this.collapseKey,
  // this.contentAvailable = false,
  // this.data = const <String, dynamic>{},
  // this.from,
  // this.messageId,
  // this.messageType,
  // this.mutableContent = false,
  // this.notification,
  // this.sentTime,
  // this.threadId,
  // this.ttl
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print(message.senderId);
    print(message.category);
    print(message.notification?.title);
    print(message.notification?.body);


    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const ProviderScope(child: OhshoShutsujin()));
}

class OhshoShutsujin extends HookConsumerWidget {
  const OhshoShutsujin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '王将出陣',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotosansJP',
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
