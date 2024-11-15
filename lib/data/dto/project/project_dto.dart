import 'dart:convert';

class ProjectDto {
  String? id;
  String? name;
  int? commentCount;
  String? color;
  bool? isShared;
  int? order;
  bool? isFavorite;
  bool? isInboxProject;
  bool? isTeamInbox;
  String? viewStyle;
  String? url;
  String? parentId;

  ProjectDto({
    this.id,
    this.name,
    this.commentCount,
    this.color,
    this.isShared,
    this.order,
    this.isFavorite,
    this.isInboxProject,
    this.isTeamInbox,
    this.viewStyle,
    this.url,
    this.parentId,
  });

  ProjectDto copyWith({
    String? id,
    String? name,
    int? commentCount,
    String? color,
    bool? isShared,
    int? order,
    bool? isFavorite,
    bool? isInboxProject,
    bool? isTeamInbox,
    String? viewStyle,
    String? url,
    String? parentId,
  }) {
    return ProjectDto(
      id: id ?? this.id,
      name: name ?? this.name,
      commentCount: commentCount ?? this.commentCount,
      color: color ?? this.color,
      isShared: isShared ?? this.isShared,
      order: order ?? this.order,
      isFavorite: isFavorite ?? this.isFavorite,
      isInboxProject: isInboxProject ?? this.isInboxProject,
      isTeamInbox: isTeamInbox ?? this.isTeamInbox,
      viewStyle: viewStyle ?? this.viewStyle,
      url: url ?? this.url,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'comment_count': commentCount,
      'color': color,
      'is_shared': isShared,
      'order': order,
      'is_favorite': isFavorite,
      'is_inbox_project': isInboxProject,
      'is_team_inbox': isTeamInbox,
      'view_style': viewStyle,
      'url': url,
      'parent_id': parentId,
    };
  }

  factory ProjectDto.fromMap(Map<String, dynamic> map) {
    return ProjectDto(
      id: map['id']?.toString(),
      name: map['name'],
      commentCount: map['comment_count'],
      color: map['color'],
      isShared: map['is_shared'],
      order: map['order'],
      isFavorite: map['is_favorite'],
      isInboxProject: map['is_inbox_project'],
      isTeamInbox: map['is_team_inbox'],
      viewStyle: map['view_style'],
      url: map['url'],
      parentId: map['parent_id']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDto.fromJson(String source) =>
      ProjectDto.fromMap(json.decode(source));
}
