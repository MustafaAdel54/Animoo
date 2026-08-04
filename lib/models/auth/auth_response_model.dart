// "statusCode": 201,
//  "message": "Signup successful!",
// "alert": "We send verfication code to your email",
// "user": {
// "id": 1,
//         "first_name": "ahmed",
//         "last_name": "elsaid",
//         "email": "ahmed122727727@gmail.com",
//         "phone": "201001398831",
//         "image_path": "http://localhost:8000/api/uploads/1749539458120.png",
//         "is_verified": "false"

class UserResponseModel {
  final int statusCode;
  final String message;
  final String alert;
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String imagePath;
  final String isVerified;
}
