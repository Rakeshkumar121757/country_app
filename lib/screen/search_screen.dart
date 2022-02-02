import 'package:countries/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountrySearch extends StatefulWidget {
  const CountrySearch({Key? key}) : super(key: key);

  @override
  _CountrySearchState createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  CountryProvider? provider;
  TextEditingController _searchcontroller = TextEditingController();
  String? name;

  @override
  void dispose() {
    _searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
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
              controller: _searchcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter Code',
              ),
            ),
            SizedBox(
              height: 400,
            ),
            ElevatedButton(
              onPressed: () async {
                name = await provider!.searchCountryByCode(context,
                    code: _searchcontroller.text.trim().toUpperCase());
                _searchcontroller.clear();
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
