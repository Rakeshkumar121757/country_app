final String countryQuery = '''
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


final String languageQuery = '''
    query Query {
      languages {
        name
        code
      }
    }
  ''';