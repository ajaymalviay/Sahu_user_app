class GetLeadModel {
  bool? error;
  String? message;
  List<Data>? data;

  GetLeadModel({this.error, this.message, this.data});

  GetLeadModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? lat;
  String? lng;
  String? status;
  String? bankname;
  String? amount;
  String? assigneeId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.address,
        this.lat,
        this.lng,
        this.status,
        this.bankname,
        this.amount,
        this.assigneeId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
    bankname = json['bankname'];
    amount = json['amount'];
    assigneeId = json['assignee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['status'] = this.status;
    data['bankname'] = this.bankname;
    data['amount'] = this.amount;
    data['assignee_id'] = this.assigneeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
