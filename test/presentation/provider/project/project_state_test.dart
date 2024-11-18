import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import '../../../fixtures/project/project_fixtures.dart';

void main() {
  group('ProjectState', () {
    test('initial state should have correct values', () {
      final state = ProjectState.initial();
      
      expect(state.status, equals(ProjectProviderState.initial));
      expect(state.projects, isEmpty);
      expect(state.errorMessage, equals(''));
    });

    test('copyWith should only change specified fields', () {
      final initialState = ProjectState.initial();
      final projects = ProjectFixtures.mockProjectList();
      
      final newState = initialState.copyWith(
        status: ProjectProviderState.loading,
        projects: projects,
      );

      expect(newState.status, equals(ProjectProviderState.loading));
      expect(newState.projects, equals(projects));
      expect(newState.errorMessage, equals(initialState.errorMessage));
    });

    test('equals should work correctly', () {
      final state1 = ProjectState.initial();
      final state2 = ProjectState.initial();
      final state3 = state1.copyWith(status: ProjectProviderState.loading);

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });

    test('props should contain all fields', () {
      final state = ProjectState.initial();
      
      expect(
        state.props, 
        equals([
          state.status,
          state.projects,
          state.errorMessage,
        ])
      );
    });
  });
}