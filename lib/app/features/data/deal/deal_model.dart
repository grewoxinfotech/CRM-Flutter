class DealModel {
  String? id;
  String? dealTitle;
  String? dealName;
  String? currency;
  String? pipeline;
  String? stage;
  int? price;
  String? closedDate;
  String? project;
  String? clientId;
  String? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;

  DealModel(
      {this.id,
        this.dealTitle,
        this.dealName,
        this.pipeline,
        this.stage,
        this.currency,
        this.price,
        this.closedDate,
        this.project,
        this.clientId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  DealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealTitle = json['dealTitle'];
    dealName = json['dealName'];
    pipeline = json['pipeline'];
    stage = json['stage'];
    currency = json['currency'];
    price = json['price'];
    closedDate = json['closedDate'];
    project = json['project'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dealTitle'] = this.dealTitle;
    data['dealName'] = this.dealName;
    data['pipeline'] = this.pipeline;
    data['stage'] = this.stage;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['closedDate'] = this.closedDate;
    data['project'] = this.project;
    data['client_id'] = this.clientId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
