class GetLeadStatusModel {
  bool? error;
  String? message;
  Data? data;

  GetLeadStatusModel({this.error, this.message, this.data});

  GetLeadStatusModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? total;
  int? pending;
  int? completed;

  Data({this.total, this.pending, this.completed});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pending = json['pending'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['pending'] = this.pending;
    data['completed'] = this.completed;
    return data;
  }
}
