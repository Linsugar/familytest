class chatmodel{
  String ?name;
  String ?id;
  String ?image;
  String ?context;
  chatmodel(json){
    this.id = json[id];
    this.name = json[name];
    this.image = json[image];
    this.context = json[context];
  }
}