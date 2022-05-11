class Tag{
  String id;
  String tagName;

  Tag(
      {
        this.id = '',
        required this.tagName,
      }
      );
  Map<String, Object> toJson() =>{
    'id': id,
    'tagName' : tagName,
  };
}