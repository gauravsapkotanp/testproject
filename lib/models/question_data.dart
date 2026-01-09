class Topic {
  final int id;
  final String name;
  final List<Question> questions;

  Topic({
    required this.id,
    required this.name,
    required this.questions,
  });
}

class Question {
  final int id;
  final String text;

  Question({
    required this.id,
    required this.text,
  });
}

// Dummy data for topics and questions
final List<Topic> topicsData = [
  Topic(
    id: 1,
    name: 'Character',
    questions: [
      Question(id: 1, text: 'What does success\nmean to you?'),
      Question(id: 2, text: 'What are your core\nvalues in life?'),
      Question(id: 3, text: 'How do you handle\nfailure?'),
      Question(id: 4, text: 'What motivates you\nto keep going?'),
      Question(id: 5, text: 'Who has influenced\nyour character most?'),
    ],
  ),
  Topic(
    id: 2,
    name: 'Lifestyle',
    questions: [
      Question(id: 1, text: 'What does your ideal\nday look like?'),
      Question(id: 2, text: 'How do you maintain\nwork-life balance?'),
      Question(id: 3, text: 'What hobbies bring\nyou joy?'),
      Question(id: 4, text: 'Where do you see\nyourself in 5 years?'),
      Question(id: 5, text: 'What does home\nmean to you?'),
    ],
  ),
  Topic(
    id: 3,
    name: 'Compatibility',
    questions: [
      Question(id: 1, text: 'What makes a\nrelationship meaningful?'),
      Question(id: 2, text: 'How do you handle\nconflict with others?'),
      Question(id: 3, text: 'What qualities do you\nvalue in a partner?'),
      Question(id: 4, text: 'How important is\ncommunication to you?'),
      Question(id: 5, text: 'What does trust\nmean to you?'),
    ],
  ),
];
