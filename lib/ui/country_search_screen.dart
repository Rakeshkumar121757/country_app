import 'package:countries/provider/countryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountrySearch extends StatefulWidget {
  const CountrySearch({Key? key}) : super(key: key);

  @override
  _CountrySearchState createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  CountryProvider? countryProvider;
  TextEditingController controller = TextEditingController();
  String? name;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search By Country Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (name != null)
              Column(
                children: [
                  ListTile(
                    title: Text(name??""),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter Country Code',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.green,
              minWidth: double.infinity,
              height: 50,
              onPressed: () async {
                name = await countryProvider!.getCountryNameByCode(context,
                    code: controller.text.trim().toUpperCase());
                controller.clear();
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
