import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

class ProjectFixtures {
  static Project mockProject() {
    return Project(
      id: 'test-id-1',
      name: 'Test Project',
      commentCount: 5,
      color: '#FF0000',
      isShared: false,
      order: 1,
      isFavorite: true,
      isInboxProject: false,
      isTeamInbox: false,
      viewStyle: 'list',
      url: 'https://test.com/project',
      parentId: null,
    );
  }

  static List<Project> mockProjectList() {
    return [
      mockProject(),
      Project(
        id: 'test-id-2',
        name: 'Second Project',
        commentCount: 3,
        color: '#00FF00',
        isShared: true,
        order: 2,
        isFavorite: false,
        isInboxProject: true,
        isTeamInbox: false,
        viewStyle: 'board',
        url: 'https://test.com/project2',
        parentId: null,
      ),
    ];
  }
}
