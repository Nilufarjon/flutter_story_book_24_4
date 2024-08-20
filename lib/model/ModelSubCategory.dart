
class ModelSubCategory {
  int? id, fav, markRead, mainCatId;
  String story='', img='', title='';

  ModelSubCategory();

  ModelSubCategory.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.fav = obj['fav'];
    this.markRead = obj['mark_read'];
    this.mainCatId = obj['main_cat_id'];
    this.story = obj['story'];
    this.img = obj['img'];
    this.title = obj['title'];
  }

  // Map<String, dynamic> toMap() {
  //   var map = new HashMap<String, dynamic>();
  //   map['id'] = id;
  //   map['fav'] = fav;
  //   map['mark_read'] = markRead;
  //   map['main_cat_id'] = mainCatId;
  //   map['story'] = story;
  //   map['img'] = img;
  //   map['title'] = title;
  // }
}
