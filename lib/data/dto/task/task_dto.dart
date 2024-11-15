import 'dart:convert';

class TaskDto {
  String? id;
  String? content;
  String? description;
  int? commentCount;
  bool? isCompleted;
  int? order;
  int? priority;
  String? projectId;
  List<String>? labels;
  DateTime? due;
  String? sectionId;
  String? parentId;
  String? creatorId;
  DateTime? createdAt;
  String? assigneeId;
  String? assignerId;
  String? url;

  TaskDto({
    this.id,
    this.content,
    this.description,
    this.commentCount,
    this.isCompleted,
    this.order,
    this.priority,
    this.projectId,
    this.labels,
    this.due,
    this.sectionId,
    this.parentId,
    this.creatorId,
    this.createdAt,
    this.assigneeId,
    this.assignerId,
    this.url,
  });

  TaskDto copyWith({
    String? id,
    String? content,
    String? description,
    int? commentCount,
    bool? isCompleted,
    int? order,
    int? priority,
    String? projectId,
    List<String>? labels,
    DateTime? due,
    String? sectionId,
    String? parentId,
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    String? url,
  }) {
    return TaskDto(
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'description': description,
      'comment_count': commentCount,
      'is_completed': isCompleted,
      'order': order,
      'priority': priority,
      'project_id': projectId,
      'labels': labels,
      'due': due?.toIso8601String(),
      'section_id': sectionId,
      'parent_id': parentId,
      'creator_id': creatorId,
      'created_at': createdAt?.toIso8601String(),
      'assignee_id': assigneeId,
      'assigner_id': assignerId,
      'url': url,
    };
  }

  factory TaskDto.fromMap(Map<String, dynamic> map) {
    return TaskDto(
      id: map['id']?.toString(),
      content: map['content'],
      description: map['description'],
      commentCount: map['comment_count'],
      isCompleted: map['is_completed'],
      order: map['order'],
      priority: map['priority'],
      projectId: map['project_id']?.toString(),
      labels: List<String>.from(map['labels'] ?? []),
      due: map['due'] != null ? DateTime.parse(map['due']) : null,
      sectionId: map['section_id']?.toString(),
      parentId: map['parent_id']?.toString(),
      creatorId: map['creator_id']?.toString(),
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at']) 
          : null,
      assigneeId: map['assignee_id']?.toString(),
      assignerId: map['assigner_id']?.toString(),
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDto.fromJson(String source) => 
      TaskDto.fromMap(json.decode(source));
} 