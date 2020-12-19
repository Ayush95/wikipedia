import 'package:flutter/material.dart';
import 'package:wiki_app/model/model.dart';

import 'services/apiServices.dart';

class SearchResult extends StatefulWidget {
  final Wiki wikiData;

  const SearchResult({Key key, this.wikiData}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  openWebView(String title) async {
    await Services.launchURL(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: ListView.builder(
        itemCount: widget.wikiData.query.pages.length,
        itemBuilder: (context, index) {
          var data = widget.wikiData.query.pages[index];
          return Container(
            // width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                openWebView(data.title);
              },
              child: Card(
                elevation: 3,
                child: Container(
                  color: Colors.lightGreen[50],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data.terms == null ? 'Press to get details' : data.terms.description[0],
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
