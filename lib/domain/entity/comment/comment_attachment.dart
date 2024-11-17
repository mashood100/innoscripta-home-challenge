import 'package:equatable/equatable.dart';

class CommentAttachment with EquatableMixin {
  final String? fileName;
  final String? fileType;
  final String? fileUrl;
  final String? resourceType;

  CommentAttachment({
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.resourceType,
  });

  @override
  List<Object?> get props => [fileName, fileType, fileUrl, resourceType];

  Map<String, dynamic> toMap() {
    return {
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
      'resource_type': resourceType,
    };
  }

  factory CommentAttachment.fromMap(Map<String, dynamic> map) {
    return CommentAttachment(
      fileName: map['file_name'],
      fileType: map['file_type'],
      fileUrl: map['file_url'],
      resourceType: map['resource_type'],
    );
  }
}
