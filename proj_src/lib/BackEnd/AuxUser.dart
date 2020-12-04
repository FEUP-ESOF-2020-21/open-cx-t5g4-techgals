class AuxUser{

  String userID;
  String username;
  String email;
  List<String> interests = [];

  AuxUser(userID, username, email) {
    this.userID = userID;
    this.username = username;
    this.email = email;
  }

  getID() { return this.userID;}
  getUsername(){ return this.username;}
  getEmail(){ return this.email;}
  getInterests() { return this.interests;}
}