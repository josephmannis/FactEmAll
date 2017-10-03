abstract class Question {
 String question;

Question(String question) {
 if (question == null) {
  throw new IllegalArgumentException("Question cannot be null.");
 }
 
 this.question = question;
}

//abstract 
}