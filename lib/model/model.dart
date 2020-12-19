class Wiki {
  Wiki({
    this.batchcomplete,
    this.query,
  });

  bool batchcomplete;
  Query query;

  factory Wiki.fromJson(Map<String, dynamic> json) => Wiki(
        batchcomplete: json["batchcomplete"],
        query: Query.fromJson(json["query"]),
      );
}

class Query {
  Query({
    this.pages,
  });
  List<Page> pages;
  factory Query.fromJson(Map<String, dynamic> json) => Query(
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );
}

class Page {
  Page({
    this.pageid,
    this.ns,
    this.title,
    this.index,
    this.terms,
  });

  int pageid;
  int ns;
  String title;
  int index;
  Terms terms;

  factory Page.fromJson(Map<String, dynamic> json) {
    return json["terms"] == null ?  Page(
      pageid: json["pageid"],
      ns: json["ns"],
      title: json["title"],
      index: json["index"],
    ) : Page(
      pageid: json["pageid"],
      ns: json["ns"],
      title: json["title"],
      index: json["index"],
      terms: Terms.fromJson(json["terms"]),
    );
  }
}

class Terms {
  Terms({
    this.description,
  });

  List<String> description;

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        description: List<String>.from(json["description"].map((x) => x)),
      );
}
