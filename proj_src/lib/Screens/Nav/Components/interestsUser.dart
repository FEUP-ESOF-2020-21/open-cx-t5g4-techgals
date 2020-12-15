class UserInt {

  String username;
  String email;
  List<String> commonInterests;

  String getUsername(){
    return username;
  }
  String getEmail(){
    return email;
  }
  List<String> getList(){
    return commonInterests;
  }

  UserInt({this.username, this.email, this.commonInterests});

}