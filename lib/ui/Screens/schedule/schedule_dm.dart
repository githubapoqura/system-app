class ScheduleDm{
  String title;
  String image;
  ScheduleDm({required this.title,required this.image});

  factory ScheduleDm.fromMap(Map<String,dynamic>map){
    return ScheduleDm(title: map['title']??'', image: map['image']??'');
  }
}
