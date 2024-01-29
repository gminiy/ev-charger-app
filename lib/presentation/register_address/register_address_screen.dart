import 'package:ev_charger_app/presentation/register_address/register_address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final viewModel = context.watch<RegisterAddressViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '주소를 입력해주세요.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '주소',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: textEditingController,
              onChanged: (value) {
                viewModel.fetchAddresses(value);
              },
              decoration: InputDecoration(
                hintText: '주소 입력',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            viewModel.state.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.state.addresses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(viewModel.state.addresses[index].address),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
