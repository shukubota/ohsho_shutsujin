import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FormExample extends HookWidget {
  const FormExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: 'initial text');
    void onChange(String value) {
      print(value);
      print('onChange');
      // print(controller.value);
      print(controller.text);
    }

    useEffect(() {
      print('useeffect');
      return null;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('FormExample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(30)),
            const TextField(),
            TextField(
              controller: controller,
              onChanged: onChange,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}