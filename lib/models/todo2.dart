class Todo2{
  String id;
  String title;
  String description;
  bool completed;
  String created;
  String image;
  int prio;
  List<String> tags;

  Todo2(
      {
        this.id = '',
        required this.title,
        required this.description,
        this.completed = false,
        this.created = "",
        this.image = '',
        this.prio = 0,
        this.tags = const [],
      }
      );
  Map<String, Object> toJson() =>{
    'id': id,
    'title' : title,
    'description': description ,
    'completed' : completed,
    'created' : created,
    'image' : image,
    'prio': prio,
    'tags': tags,
  };
}