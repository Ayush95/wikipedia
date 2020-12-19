import 'package:flutter/material.dart';
import 'package:wiki_app/model/model.dart';
import 'package:wiki_app/searchResult.dart';

import 'services/apiServices.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Wiki wiki;
  bool _isLoading = false;

  TextEditingController searchController = new TextEditingController();

  searchWiki() async {
    setState(() {
      _isLoading = true;
    });
    final value = await Services.getWiki(searchController.text);
    value != null
        ? setState(
            () {
              wiki = value;
              _isLoading = false;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchResult(
                    wikiData: wiki,
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text('Oops an error occured!'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Image.asset(
                        'assets/wikipedia.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 80,
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey[900],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Wiki..',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            searchWiki();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: () {
                        searchWiki();
                      },
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
