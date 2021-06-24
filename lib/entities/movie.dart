class Movie {
  String? id;
  String? name;
  String? rating;
  late Detail detail;

  Movie fromJson(Map map) {
    id = map["Id"];
    name = map["Name"];
    rating = map["Rating"];
    detail = new Detail().fromJson(map["Detail"]);
    return this;
  }
}

class Detail {
  String? categories;
  String? censor;
  String? content;
  String? duration;
  String? urlforGraphic;

  Detail fromJson(Map map) {
    categories = map["Categories"];
    censor = map["Censor"];
    content = map["Content"];
    duration = map["Duration"];
    urlforGraphic = map["URLforGraphic"];

    return this;
  }
}
