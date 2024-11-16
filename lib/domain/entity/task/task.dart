import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';

class Task extends TaskDto with EquatableMixin {
  @override
  final TaskDuration? duration;

  Task({
    String? id,
    String? content,
    String? description,
    int? commentCount,
    bool? isCompleted,
    int? order,
    int? priority,
    String? projectId,
    List<String>? labels,
    Due? due,
    String? sectionId,
    String? parentId,
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    String? url,
    int? durationInMinutes,
  })  : duration = durationInMinutes != null
            ? TaskDuration(amount: durationInMinutes, unit: 'minute')
            : null,
        super(
          id: id,
          content: content,
          description: description,
          commentCount: commentCount,
          isCompleted: isCompleted,
          order: order,
          priority: priority,
          projectId: projectId,
          labels: labels,
          due: due,
          sectionId: sectionId,
          parentId: parentId,
          creatorId: creatorId,
          createdAt: createdAt,
          assigneeId: assigneeId,
          assignerId: assignerId,
          url: url,
          duration: durationInMinutes != null
              ? TaskDuration(amount: durationInMinutes, unit: 'minute')
              : null,
        );

  int? get durationInMinutes => duration?.amount;

  @override
  Task copyWith({
    String? id,
    String? content,
    String? description,
    int? commentCount,
    bool? isCompleted,
    int? order,
    int? priority,
    String? projectId,
    List<String>? labels,
    Due? due,
    String? sectionId,
    String? parentId,
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    String? url,
    TaskDuration? duration,
  }) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      description: description ?? this.description,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      labels: labels ?? this.labels,
      due: due ?? this.due,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      url: url ?? this.url,
    );
  }

  TaskDto toDto() {
    return TaskDto(
      id: id,
      content: content,
      description: description,
      commentCount: commentCount,
      isCompleted: isCompleted,
      order: order,
      priority: priority,
      projectId: projectId,
      labels: labels,
      due: due,
      sectionId: sectionId,
      parentId: parentId,
      creatorId: creatorId,
      createdAt: createdAt,
      assigneeId: assigneeId,
      assignerId: assignerId,
      url: url,
      duration: durationInMinutes != null
          ? TaskDuration(amount: durationInMinutes ?? 0, unit: 'minute')
          : null,
    );
  }

  static Task fromDto(TaskDto dto) {
    return Task(
      id: dto.id,
      content: dto.content,
      description: dto.description,
      commentCount: dto.commentCount,
      isCompleted: dto.isCompleted,
      order: dto.order,
      priority: dto.priority,
      projectId: dto.projectId,
      labels: dto.labels,
      due: dto.due,
      sectionId: dto.sectionId,
      parentId: dto.parentId,
      creatorId: dto.creatorId,
      createdAt: dto.createdAt,
      assigneeId: dto.assigneeId,
      assignerId: dto.assignerId,
      url: dto.url,
      durationInMinutes: dto.duration?.amount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        content,
        description,
        commentCount,
        isCompleted,
        order,
        priority,
        projectId,
        labels,
        due,
        sectionId,
        parentId,
        creatorId,
        createdAt,
        assigneeId,
        assignerId,
        url,
        durationInMinutes,
      ];
}
