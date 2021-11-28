import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Panel extends HookWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('ここ'),
    );
  }
}