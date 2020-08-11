class DisplayList {
  final List<Display> displayItems;

  DisplayList(this.displayItems);

  factory DisplayList.fromJson(List<dynamic> snapshot) {
    List<Display> dis = List<Display>();
    dis = snapshot.map((e) => Display.fromJson(e)).toList();
    return DisplayList(dis);
  }
}

class Display {
  String hindi;
  String name;
  String key;
  String url;

  Display({this.hindi, this.name, this.key, this.url});

  Display.fromJson(Map<String, dynamic> json) {
    hindi = json['hindi'];
    name = json['name'];
    key = json['key'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hindi'] = this.hindi;
    data['name'] = this.name;
    data['key'] = this.key;
    data['url'] = this.url;
    return data;
  }
}
