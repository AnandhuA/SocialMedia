class PostModel {
  final String post;
  final String description;
  final List likes;
  final String createDate;
  final String updateDate;

  PostModel({
    required this.post,
    required this.description,
    required this.likes,
    required this.createDate,
    required this.updateDate,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      post: json['image'] ?? '',
      description: json['description'] ?? '',
      likes: json['likes'] != null ? List<String>.from(json['likes']) : [],
      createDate: json['createdAt'] ?? '',
      updateDate: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': post,
      'description': description,
      'likes': likes,
      'createdAt': createDate,
      'updatedAt': updateDate,
    };
  }
}





// [
//   {
//     "_id":"666c63ac660b629740de0557",
//   "userId":{
//     "_id":"6664110bda03f495b6ec6d6d",
//     "userName":"anandhu23",
//     "email":"anandhuav14@gmail.com",
//     "password":"$2a$10$iXqkohCNsHD9a9JlRr032OJe9SNxOPm8NtajY.axT5m3OlGx9mmru",
//     "profilePic":"https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
//     "online":false,
//     "blocked":false,
//     "verified":false,
//     "role":"User",
//     "isPrivate":false,
//     "backGroundImage":"https://img.freepik.com/free-photo/artistic-blurry-colorful-wallpaper-background_58702-8192.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1712361600&semt=ais",
//     "createdAt":"2024-06-08T08:06:35.408Z",
//     "updatedAt":"2024-06-08T08:06:35.408Z",
//     "__v":0
//     },
//     "image":"http://res.cloudinary.com/dm27venn4/image/upload/v1718379434/ubfdjagporwolcxgcwuk.jpg",
//     "description":"Welcome",
//     "likes":[],
//     "hidden":false,
//     "blocked":false,
//     "tags":[],
//     "taggedUsers":[],
//     "date":"2024-06-14T15:37:16.938Z",
//     "createdAt":"2024-06-14T15:37:16.939Z",
//     "updatedAt":"2024-06-14T15:37:16.939Z",
//     "__v":0
//     },
//     {
//       "_id":"666c631c660b629740de0553",
//     "userId":{
//       "_id":"6664110bda03f495b6ec6d6d",
//       "userName":"anandhu23",
//       "email":"anandhuav14@gmail.com",
//       "password":"$2a$10$iXqkohCNsHD9a9JlRr032OJe9SNxOPm8NtajY.axT5m3OlGx9mmru",
//       "profilePic":"https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
//       "online":false,
//       "blocked":false,
//       "verified":false,
//       "role":"User",
//       "isPrivate":false,
//       "backGroundImage":"https://img.freepik.com/free-photo/artistic-blurry-colorful-wallpaper-background_58702-8192.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1712361600&semt=ais",
//       "createdAt":"2024-06-08T08:06:35.408Z",
//       "updatedAt":"2024-06-08T08:06:35.408Z",
//       "__v":0
//       },
//       "image":"http://res.cloudinary.com/dm27venn4/image/upload/v1718379289/jnb1jm0eftmh2yyk3sfu.jpg",
//       "description":"",
//       "likes":[],
//       "hidden":false,
//       "blocked":false,
//       "tags":[],
//       "taggedUsers":[],
//       "date":"2024-06-14T15:34:52.107Z",
//       "createdAt":"2024-06-14T15:34:52.114Z",
//       "updatedAt":"2024-06-14T15:34:52.114Z",
//       "__v":0
//       }
// ]