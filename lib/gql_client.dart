import 'dart:convert';

import 'package:countries/gql_query.dart';
import 'package:countries/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Api {
  final AuthLink authLink = AuthLink(
    getToken: () => "",
  );
  GraphQLClient? client;
  CountryBaseModel? countries;

  Api() {
    client = GraphQLClient(
        link: authLink.concat(HttpLink(
          'https://countries.trevorblades.com/graphql',
        )),
        cache: GraphQLCache());
  }

  Future getCountry() async {
    final QueryResult result = await client!.query(
      QueryOptions(
        document: gql(countryQuery),
      ),
    );
    return json.encode(result.data);
  }

  Future getLanguages() async {
    final QueryResult result = await client!.query(
      QueryOptions(
        document: gql(languageQuery),
      ),
    );
    return json.encode(result.data?['languages']);
  }

  Future getCountryByCode(context, {required String code}) async {
    final String query = '''
    query Query {
      country(code: "$code") {
      name
      }
    }
  ''';
    final QueryResult response = await client!.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    if (response.hasException) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Country not available"),
      ));
      return null;
    }
    return json.encode(response.data);
  }
}
