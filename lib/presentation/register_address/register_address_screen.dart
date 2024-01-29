import 'package:flutter/material.dart';

class RegisterAddressScreen extends StatefulWidget {
  const RegisterAddressScreen({super.key});

  @override
  State<RegisterAddressScreen> createState() => _RegisterAddressScreenState();
}

class _RegisterAddressScreenState extends State<RegisterAddressScreen> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('주소 입력')),
      body: Column(
        children: [
          Text(
            '주소를 입력해주세요.',
            style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),
          Text('주소'),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: '주소 입력',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 3),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
