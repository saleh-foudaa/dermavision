class Question {
  final String id;
  final String text;
  final int order;
  final bool isMultiple;
  final List<Answer> answers;
  final bool active;

  Question({
    required this.id,
    required this.text,
    required this.order,
    required this.isMultiple,
    required this.answers,
    required this.active,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      text: json['text'],
      order: json['order'],
      isMultiple: json['isMultiple'] ?? false,
      answers: (json['answer'] as List<dynamic>)
          .map((a) => Answer.fromJson(a))
          .toList(),
      active: json['active'] ?? true,
    );
  }
}

class Answer {
  final String id;
  final String text;

  Answer({
    required this.id,
    required this.text,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['_id'],
      text: json['text'],
    );
  }
}

// class Question {
//   final String id;
//   final String text;
//   final int order;
//   final bool isMultiChoice; // تغيير من isMultiDevice إلى isMultiChoice
//   final List<Answer> answers;
//   final bool isConfirmation;
//   final bool active;
//
//   Question({
//     required this.id,
//     required this.text,
//     required this.order,
//     required this.isMultiChoice,
//     required this.answers,
//     required this.isConfirmation,
//     required this.active,
//   });
//
//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//       id: json['_id'],
//       text: json['text'],
//       order: json['order'],
//       isMultiChoice: json['isMultiChoice'] ?? false, // قيمة افتراضية إذا كانت null
//       answers: List<Answer>.from(
//           json['answer'].map((answer) => Answer.fromJson(answer))),
//       isConfirmation: json['isConfirmation'] ?? false,
//       active: json['active'] ?? true,
//     );
//   }
// }
//
// class Answer {
//   final String id;
//   final String text;
//
//   Answer({
//     required this.id,
//     required this.text,
//   });
//
//   factory Answer.fromJson(Map<String, dynamic> json) {
//     return Answer(
//       id: json['_id'],
//       text: json['text'],
//     );
//   }
// }