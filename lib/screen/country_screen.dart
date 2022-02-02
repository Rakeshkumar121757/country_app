import 'package:countries/model/country_model.dart';
import 'package:countries/provider.dart';
import 'package:countries/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  CountryProvider? provider;
  List<CountryRemoteModel> _filter = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) async{
      await provider?.countryByName();
      await provider?.getLanguages();
    });
  }

  @override
  void dispose() {
    provider?.countries.clear();
    provider?.languages.clear();
    _filter.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);
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
          _filter.isEmpty
              ? IconButton(
                  onPressed: () {
                    filterBottomSheet();
                  },
                  icon: Icon(Icons.filter),
                )
              : IconButton(
                  onPressed: () {
                    _filter.clear();
                    provider?.refreshScreen();
                  },
                  icon: Icon(Icons.close),
                ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: provider!.countries.isEmpty
                ? Center(child: CircularProgressIndicator())
                : _filter.isEmpty
                    ? countrylist()
                    : _filterlist(),
          ),
        ],
      ),
    );
  }

  Widget countrylist() {
    return ListView.builder(
        itemCount: provider?.countries.length,
        itemBuilder: (context, index) {
          final countryName = provider?.countries[index].name;
          final countryLanguage = provider?.countries[index]?.languages;
          return ListTile(
            title: Text(countryName ?? ""),
            subtitle: countryLanguage!.isNotEmpty && countryLanguage[0] != null
                ? Text(countryLanguage[0].name)
                : Text(""),
          );
        });
  }

  Widget _filterlist() {
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (context, index) {
          final countryName = _filter[index].name;
          final countryLanguage = _filter[index].languages;
          return ListTile(
            title: Text(countryName),
            subtitle: countryLanguage.isNotEmpty && countryLanguage[0] != null
                ? Text(countryLanguage[0].name)
                : Text(""),
          );
        });
  }

  filterBottomSheet() {
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
                const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Languages",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: provider?.languages.length,
                      itemBuilder: (context, index) {
                        final name = provider?.languages[index].name;
                        return ListTile(
                          onTap: () async {
                            await filter(name);
                            provider?.refreshScreen();
                            Navigator.of(context).pop();
                          },
                          title: Text(name ?? ""),
                        );
                      }),
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
    List<CountryRemoteModel> _tempCountries = [];
    _tempCountries.addAll(provider!.countries);
    for (var v in _tempCountries) {
      for (var l in v.languages) {
        if (l.name.toLowerCase().contains(languageName.toLowerCase())) {
          _filter.add(v);
        }
      }
    }
  }
}
