class CommentDtoFixtures {
  static Map<String, dynamic> mockCommentMap() {
    return {
      'id': 'comment-1',
      'content': 'Test Comment',
      'posted_at': '2024-01-01T00:00:00Z',
      'project_id': 'project-1',
      'task_id': 'task-1',
      'attachment': {
        'file_name': 'test.pdf',
        'file_type': 'application/pdf',
        'file_url': 'https://test.com/files/test.pdf',
        'resource_type': 'file'
      }
    };
  }

  static String mockCommentJson() {
    return '''
    {
      "id": "comment-1",
      "content": "Test Comment",
      "posted_at": "2024-01-01T00:00:00Z",
      "project_id": "project-1",
      "task_id": "task-1",
      "attachment": {
        "file_name": "test.pdf",
        "file_type": "application/pdf",
        "file_url": "https://test.com/files/test.pdf",
        "resource_type": "file"
      }
    }
    ''';
  }

  static String mockCommentListJson() {
    return '''
    [
      ${mockCommentJson()},
      {
        "id": "comment-2",
        "content": "Second Comment",
        "posted_at": "2024-01-02T00:00:00Z",
        "project_id": "project-1",
        "task_id": "task-1"
      }
    ]
    ''';
  }
}