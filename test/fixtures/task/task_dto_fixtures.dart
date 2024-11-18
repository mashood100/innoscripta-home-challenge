class TaskDtoFixtures {
  static Map<String, dynamic> mockTaskMap() {
    return {
      'id': 'task-1',
      'content': 'Test Task',
      'description': 'Test Description',
      'comment_count': 3,
      'is_completed': false,
      'order': 1,
      'priority': 1,
      'project_id': 'project-1',
      'labels': ['label1', 'label2'],
      'due': {
        'date': '2024-03-20',
        'string': 'tomorrow',
        'lang': 'en',
        'is_recurring': false,
        'datetime': '2024-03-20T10:00:00Z'
      },
      'section_id': 'section-1',
      'parent_id': null,
      'creator_id': 'creator-1',
      'created_at': '2024-01-01T00:00:00Z',
      'assignee_id': 'assignee-1',
      'assigner_id': 'assigner-1',
      'url': 'https://test.com/task',
      'duration': {
        'amount': 60,
        'unit': 'minutes'
      }
    };
  }

  static String mockTaskJson() {
    return '''
    {
      "id": "task-1",
      "content": "Test Task",
      "description": "Test Description",
      "comment_count": 3,
      "is_completed": false,
      "order": 1,
      "priority": 1,
      "project_id": "project-1",
      "labels": ["label1", "label2"],
      "due": {
        "date": "2024-03-20",
        "string": "tomorrow",
        "lang": "en",
        "is_recurring": false,
        "datetime": "2024-03-20T10:00:00Z"
      },
      "section_id": "section-1",
      "creator_id": "creator-1",
      "created_at": "2024-01-01T00:00:00Z",
      "assignee_id": "assignee-1",
      "assigner_id": "assigner-1",
      "url": "https://test.com/task",
      "duration": {
        "amount": 60,
        "unit": "minutes"
      }
    }
    ''';
  }

  static String mockTaskListJson() {
    return '''
    [
      ${mockTaskJson()},
      {
        "id": "task-2",
        "content": "Second Task",
        "description": "Second Description",
        "is_completed": true,
        "project_id": "project-1",
        "duration": {
          "amount": 30,
          "unit": "minutes"
        }
      }
    ]
    ''';
  }
}