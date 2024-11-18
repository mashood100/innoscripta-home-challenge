
class ProjectDtoFixtures {
  static Map<String, dynamic> mockProjectMap() {
    return {
      'id': 'test-id-1',
      'name': 'Test Project',
      'comment_count': 5,
      'color': '#FF0000',
      'is_shared': false,
      'order': 1,
      'is_favorite': true,
      'is_inbox_project': false,
      'is_team_inbox': false,
      'view_style': 'list',
      'url': 'https://test.com/project',
      'parent_id': null,
    };
  }

  static String mockProjectJson() {
    return '{"id":"test-id-1","name":"Test Project","comment_count":5,"color":"#FF0000","is_shared":false,"order":1,"is_favorite":true,"is_inbox_project":false,"is_team_inbox":false,"view_style":"list","url":"https://test.com/project","parent_id":null}';
  }

  static String mockProjectListJson() {
    return '[${mockProjectJson()},${mockProjectJson()}]';
  }
}
