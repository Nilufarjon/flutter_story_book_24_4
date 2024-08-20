class ModelMainCat {
  int? id;
  String catName = '', catImg = '';

  ModelMainCat();

  ModelMainCat.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.catImg = obj['cat_img'];
    this.catName = obj['cat_name'];
  }
}
