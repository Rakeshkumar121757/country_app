import 'dart:convert';

import 'package:countries/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Api {
  final HttpLink httpLink = HttpLink(
    'https://countries.trevorblades.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () => "",
  );
  GraphQLClient? client;
  CountryBaseModel? countries;

  Api() {
    client = GraphQLClient(link: authLink.concat(httpLink), cache: GraphQLCache());
  }

  Future getCountry() async {
    final String query = '''
    query {
      countries {
        name
        languages {
          code
          name
        }
      }
    }
  ''';
    final QueryResult result = await client!.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    return json.encode(result.data);
  }

  Future getLanguages() async {
    final String query = '''
    query Query {
      languages {
        name
        code
      }
    }
  ''';
    final QueryResult result = await client!.query(
      QueryOptions(
        document: gql(query),
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
    final QueryResult result = await client!.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    if (result.hasException) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Country Code doesn't exists"),
        backgroundColor: Colors.red,
      ));
      return null;
    }

    return json.encode(result.data);
  }
}
