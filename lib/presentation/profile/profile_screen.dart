import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '개인 정보 관리',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildProfileContent(context),
        ),
        bottomNavigationBar: buildBottomButton(context),
      ),
    );
  }

  void unfocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Widget buildProfileContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        buildProfileRow('별명', '별명을 입력해주세요.', true),
        buildProfileRow('주소', '강원도 춘천시 퇴계동 퇴계주공7단지', false),
        buildAddressChangeButton(),
      ],
    );
  }

  Widget buildProfileRow(String label, String value, bool isTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 64.0),
              child: isTextField ? buildTextField(value) : buildText(value),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      onChanged: (value) {},
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: underlineInputBorder(),
        focusedBorder: underlineInputBorder(),
      ),
    );
  }

  Widget buildText(String text) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  InputBorder underlineInputBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black12),
    );
  }

  Widget buildAddressChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [addressChangeButton()],
    );
  }

  Widget addressChangeButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // 버튼 색상
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: const Text(
        '주소 변경',
        style: TextStyle(fontSize: 16, color: Colors.black87), // 텍스트 색상
      ),
    );
  }

  Widget buildBottomButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 8.0,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[200], // 버튼 색상
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: const Text(
          '변경 완료',
          style: TextStyle(fontSize: 16, color: Colors.black87), // 텍스트 색상
        ),
      ),
    );
  }
}
