import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'dart:async';

class Query {

  static Future<Map<String, dynamic>> query(String queryString) {

    var url = "http://openvolontario.opencontent.it/opendata/api/content/search/" + queryString;
    url = Uri.encodeFull(url);

    return http.get(url).then((response) {
      return json.decode(response.body);
    });

  }

}