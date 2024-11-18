import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

class ProjectFixtures {
  static List<Project> mockProjectList() {
    return [
      Project(
        id: '1',
        name: 'Test Project 1',
        color: 'berry_red',
        isFavorite: false,
      ),
      Project(
        id: '2',
        name: 'Test Project 2',
        color: 'blue',
        isFavorite: true,
      ),
    ];
  }

  static Project mockProject() {
    return Project(
      id: '1',
      name: 'Test Project',
      color: 'berry_red',
      isFavorite: false,
    );
  }
}
