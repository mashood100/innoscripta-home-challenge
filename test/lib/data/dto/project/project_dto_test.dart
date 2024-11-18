import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/data/dto/project/project_dto.dart';

import '../../../../fixtures/project/project_dto_fixtures.dart';

void main() {
  group('ProjectDto', () {
    test('should create ProjectDto with default values', () {
      final dto = ProjectDto();
      
      expect(dto.id, isNull);
      expect(dto.name, isNull);
      expect(dto.isFavorite, false);
    });

    test('fromMap should create ProjectDto with correct values', () {
      final map = ProjectDtoFixtures.mockProjectMap();
      final dto = ProjectDto.fromMap(map);

      expect(dto.id, 'test-id-1');
      expect(dto.name, 'Test Project');
      expect(dto.commentCount, 5);
      expect(dto.color, '#FF0000');
      expect(dto.isShared, false);
      expect(dto.order, 1);
      expect(dto.isFavorite, true);
    });

    test('toMap should convert ProjectDto to Map correctly', () {
      final dto = ProjectDto(
        id: 'test-id-1',
        name: 'Test Project',
        commentCount: 5,
        color: '#FF0000',
      );

      final map = dto.toMap();
      expect(map['id'], 'test-id-1');
      expect(map['name'], 'Test Project');
      expect(map['comment_count'], 5);
      expect(map['color'], '#FF0000');
    });

    test('copyWith should return new instance with updated values', () {
      final dto = ProjectDto(id: 'test-id-1', name: 'Test Project');
      final updated = dto.copyWith(name: 'Updated Project');

      expect(updated.id, 'test-id-1');
      expect(updated.name, 'Updated Project');
    });
  });
}