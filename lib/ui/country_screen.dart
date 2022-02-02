
import 'package:countries/model/country_model.dart';
import 'package:countries/provider/countryProvider.dart';
import 'package:countries/ui/country_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({Key? key,}) : super(key: key);


  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  CountryProvider? countryProvider;
  List<CountryElement> _filterCountries = [];

  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await countryProvider?.getCountryName();
      await countryProvider?.getLanguages();
    });
  }

  @override
  void dispose() {
    countryProvider?.countries.clear();
    countryProvider?.languages.clear();
    _filterCountries.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    countryProvider = Provider.of<CountryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        actions: [
          IconButton(
            onPressed: () {
              Route route = MaterialPageRoute(builder: (_) => CountrySearch());
              Navigator.push(context, route);
            },
            icon: Icon(Icons.search),
          ),
          _filterCountries.isEmpty
              ? IconButton(
                  onPressed: () {
                    onShowSymptom();
                  },
                  icon: Icon(Icons.filter),
                )
              : IconButton(
                  onPressed: () {
                    _filterCountries.clear();
                    countryProvider?.refreshScreen();
                  },
                  icon: Icon(Icons.close),
                ),
        ],
      ),
      body: Column(
        children: [
          if (_filterCountries.isNotEmpty)
            Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text('${_filterCountries.length} is filter')),
          Expanded(
            child: countryProvider!.countries.isEmpty
                ? Center(child: CircularProgressIndicator())
                : _filterCountries.isEmpty
                    ? _buildList()
                    : _buildFilterList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: countryProvider?.countries.length,
        itemBuilder: (context, index) {
          final countryName = countryProvider?.countries[index].name;
          final countryLanguage = countryProvider?.countries[index]?.languages;
          return ListTile(
            title: Text(countryName??""),
            subtitle: countryLanguage!.isNotEmpty && countryLanguage[0] != null
                ? Text(countryLanguage[0].name)
                : Text(""),
          );
        });
  }

  Widget _buildFilterList() {
    return ListView.builder(
        itemCount: _filterCountries.length,
        itemBuilder: (context, index) {
          final countryName = _filterCountries[index].name;
          final countryLanguage = _filterCountries[index].languages;
          return ListTile(
            title: Text(countryName),
            subtitle: countryLanguage.isNotEmpty && countryLanguage[0] != null
                ? Text(countryLanguage[0].name)
                : Text(""),
          );
        });
  }

  onShowSymptom() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Filter",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: countryProvider?.languages.length,
                      itemBuilder: (context, index) {
                        final name = countryProvider?.languages[index].name;
                        return ListTile(
                          onTap: ()async {
                            await filter(name);
                            countryProvider?.refreshScreen();
                            Navigator.of(context).pop();
                          },
                          title: Text(name??""),);
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future filter(languageName) async {
    List<CountryElement> _tempCountries = [];
    _tempCountries.addAll(countryProvider!.countries);
    for (var v in _tempCountries) {
      for (var l in v.languages) {
        if (l.name
            .toLowerCase()
            .contains(languageName.toLowerCase())) {
          _filterCountries.add(v);
        }
      }
    }
  }
}
