import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wiki_app/model/model.dart';

class Services {
  static Future getWiki(String query) async {
    try {
      final url =
          "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=$query";
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        Wiki wikiData = Wiki.fromJson(result);
        return wikiData;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future launchURL(String queryWeb) async {
    final url = 'https://en.wikipedia.org/wiki/$queryWeb';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
