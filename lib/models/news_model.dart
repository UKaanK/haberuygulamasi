class NewsModel {
  NewsModel({
    required this.key,
    required this.url,
    required this.description,
    required this.image,
    required this.name,
    required this.source,
  });
  late final String key;
  late final String url;
  late final String description;
  late final String image;
  late final String name;
  late final String source;
  
  NewsModel.fromJson(Map<String, dynamic> json){
    key = json['key'];
    url = json['url'];
    description = json['description'];
    image = json['image'];
    name = json['name'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['url'] = url;
    _data['description'] = description;
    _data['image'] = image;
    _data['name'] = name;
    _data['source'] = source;
    return _data;
  }
}