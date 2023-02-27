class ListItem {
  String? id;
  String? title;
  int? price;
  String? executionTime;
  String? creationTime;
  String? modificationTime;
  String? location;
  String? owner;

  ListItem(
      {this.id,
      this.title,
      this.price,
      this.executionTime,
      this.creationTime,
      this.modificationTime,
      this.location,
      this.owner});

  ListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    executionTime = json['executionTime'];
    creationTime = json['creationTime'];
    modificationTime = json['modificationTime'];
    location = json['location'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['executionTime'] = executionTime;
    data['creationTime'] = creationTime;
    data['modificationTime'] = modificationTime;
    data['location'] = location;
    data['owner'] = owner;
    return data;
  }
}
