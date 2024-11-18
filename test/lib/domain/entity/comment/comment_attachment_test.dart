import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment_attachment.dart';
import '../../../../fixtures/comment/comment_fixtures.dart';

void main() {
  group('CommentAttachment', () {
    test('should create CommentAttachment instance with correct values', () {
      final attachment = CommentFixtures.mockCommentAttachment();

      expect(attachment.fileName, 'test.pdf');
      expect(attachment.fileType, 'application/pdf');
      expect(attachment.fileUrl, 'https://test.com/files/test.pdf');
      expect(attachment.resourceType, 'file');
    });

    test('toMap should convert CommentAttachment to Map', () {
      final attachment = CommentFixtures.mockCommentAttachment();
      final map = attachment.toMap();

      expect(map['file_name'], attachment.fileName);
      expect(map['file_type'], attachment.fileType);
      expect(map['file_url'], attachment.fileUrl);
      expect(map['resource_type'], attachment.resourceType);
    });

    test('fromMap should convert Map to CommentAttachment', () {
      final map = {
        'file_name': 'test.pdf',
        'file_type': 'application/pdf',
        'file_url': 'https://test.com/files/test.pdf',
        'resource_type': 'file',
      };

      final attachment = CommentAttachment.fromMap(map);

      expect(attachment.fileName, map['file_name']);
      expect(attachment.fileType, map['file_type']);
      expect(attachment.fileUrl, map['file_url']);
      expect(attachment.resourceType, map['resource_type']);
    });

    test('props should contain all properties', () {
      final attachment = CommentFixtures.mockCommentAttachment();
      expect(
        attachment.props,
        [
          attachment.fileName,
          attachment.fileType,
          attachment.fileUrl,
          attachment.resourceType,
        ],
      );
    });
  });
}