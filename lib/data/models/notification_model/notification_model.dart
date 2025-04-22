class NotificationModel {
  int? id;
  int? toUser;
  String? title;
  String? message;
  int? senderId;
  String? createdAt;
  String? profileUrl;
  bool isNew;

  NotificationModel({
    this.id,
    this.toUser,
    this.title,
    this.message,
    this.senderId,
    this.createdAt,
    this.profileUrl,
    this.isNew = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      toUser: json['to_user'] as int?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      senderId: json['senderId'] as int?,
      createdAt: json['created_at'] as String?,
      profileUrl: json['profile_url'] as String?,
    );
  }
}
