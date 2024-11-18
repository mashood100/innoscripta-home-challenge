import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/data/dto/project/project_dto.dart';

class Project extends ProjectDto with EquatableMixin {
  Project({
    super.id,
    super.name,
    super.commentCount,
    super.color,
    super.isShared,
    super.order,
    super.isFavorite = false,
    super.isInboxProject,
    super.isTeamInbox,
    super.viewStyle,
    super.url,
    super.parentId,
  });

  Project copyWith({
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
    return Project(
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

  ProjectDto toDto() {
    return ProjectDto(
      id: id,
      name: name,
      commentCount: commentCount,
      color: color,
      isShared: isShared,
      order: order,
      isFavorite: isFavorite,
      isInboxProject: isInboxProject,
      isTeamInbox: isTeamInbox,
      viewStyle: viewStyle,
      url: url,
      parentId: parentId,
    );
  }

  static Project fromDto(ProjectDto dto) {
    return Project(
      id: dto.id,
      name: dto.name,
      commentCount: dto.commentCount,
      color: dto.color,
      isShared: dto.isShared,
      order: dto.order,
      isFavorite: dto.isFavorite,
      isInboxProject: dto.isInboxProject,
      isTeamInbox: dto.isTeamInbox,
      viewStyle: dto.viewStyle,
      url: dto.url,
      parentId: dto.parentId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        commentCount,
        color,
        isShared,
        order,
        isFavorite,
        isInboxProject,
        isTeamInbox,
        viewStyle,
        url,
        parentId,
      ];
}
