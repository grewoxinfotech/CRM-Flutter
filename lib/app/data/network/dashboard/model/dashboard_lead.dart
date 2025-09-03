class LeadAggregationResponse {
  final bool success;
  final Message? message;
  final dynamic data;

  LeadAggregationResponse({required this.success, this.message, this.data});

  factory LeadAggregationResponse.fromJson(Map<String, dynamic> json) {
    return LeadAggregationResponse(
      success: json['success'] ?? false,
      message:
          json['message'] != null ? Message.fromJson(json['message']) : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message?.toJson(),
    'data': data,
  };
}

class Message {
  final Aggregations? aggregations;
  final Metadata? metadata;

  Message({this.aggregations, this.metadata});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      aggregations:
          json['aggregations'] != null
              ? Aggregations.fromJson(json['aggregations'])
              : null,
      metadata:
          json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'aggregations': aggregations?.toJson(),
    'metadata': metadata?.toJson(),
  };
}

class Aggregations {
  final List<StageAggregation>? byStage;
  final List<StatusAggregation>? byStatus;
  final List<SourceAggregation>? bySource;
  final List<InterestLevelAggregation>? byInterestLevel;

  Aggregations({
    this.byStage,
    this.byStatus,
    this.bySource,
    this.byInterestLevel,
  });

  factory Aggregations.fromJson(Map<String, dynamic> json) {
    return Aggregations(
      byStage:
          json['byStage'] != null
              ? List<StageAggregation>.from(
                json['byStage'].map((x) => StageAggregation.fromJson(x)),
              )
              : null,
      byStatus:
          json['byStatus'] != null
              ? List<StatusAggregation>.from(
                json['byStatus'].map((x) => StatusAggregation.fromJson(x)),
              )
              : null,
      bySource:
          json['bySource'] != null
              ? List<SourceAggregation>.from(
                json['bySource'].map((x) => SourceAggregation.fromJson(x)),
              )
              : null,
      byInterestLevel:
          json['byInterestLevel'] != null
              ? List<InterestLevelAggregation>.from(
                json['byInterestLevel'].map(
                  (x) => InterestLevelAggregation.fromJson(x),
                ),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'byStage': byStage?.map((x) => x.toJson()).toList(),
    'byStatus': byStatus?.map((x) => x.toJson()).toList(),
    'bySource': bySource?.map((x) => x.toJson()).toList(),
    'byInterestLevel': byInterestLevel?.map((x) => x.toJson()).toList(),
  };
}

class StageAggregation {
  final String stage;
  final String stageName;
  final int leadCount;

  StageAggregation({
    required this.stage,
    required this.stageName,
    required this.leadCount,
  });

  factory StageAggregation.fromJson(Map<String, dynamic> json) {
    return StageAggregation(
      stage: json['stage'] ?? '',
      stageName: json['stageName'] ?? '',
      leadCount: json['leadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'stage': stage,
    'stageName': stageName,
    'leadCount': leadCount,
  };
}

class StatusAggregation {
  final String status;
  final String statusName;
  final int leadCount;

  StatusAggregation({
    required this.status,
    required this.statusName,
    required this.leadCount,
  });

  factory StatusAggregation.fromJson(Map<String, dynamic> json) {
    return StatusAggregation(
      status: json['status'] ?? '',
      statusName: json['statusName'] ?? '',
      leadCount: json['leadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'statusName': statusName,
    'leadCount': leadCount,
  };
}

class SourceAggregation {
  final String source;
  final String sourceName;
  final int leadCount;

  SourceAggregation({
    required this.source,
    required this.sourceName,
    required this.leadCount,
  });

  factory SourceAggregation.fromJson(Map<String, dynamic> json) {
    return SourceAggregation(
      source: json['source'] ?? '',
      sourceName: json['sourceName'] ?? '',
      leadCount: json['leadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'source': source,
    'sourceName': sourceName,
    'leadCount': leadCount,
  };
}

class InterestLevelAggregation {
  final String interestLevel;
  final int leadCount;

  InterestLevelAggregation({
    required this.interestLevel,
    required this.leadCount,
  });

  factory InterestLevelAggregation.fromJson(Map<String, dynamic> json) {
    return InterestLevelAggregation(
      interestLevel: json['interestLevel'] ?? '',
      leadCount: json['leadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'interestLevel': interestLevel,
    'leadCount': leadCount,
  };
}

class Metadata {
  final int totalLeads;
  final NewestLead? newestLead;

  Metadata({required this.totalLeads, this.newestLead});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      totalLeads: json['totalLeads'] ?? 0,
      newestLead:
          json['newestLead'] != null
              ? NewestLead.fromJson(json['newestLead'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalLeads': totalLeads,
    'newestLead': newestLead?.toJson(),
  };
}

class NewestLead {
  final String id;
  final String leadTitle;
  final String createdAt;

  NewestLead({
    required this.id,
    required this.leadTitle,
    required this.createdAt,
  });

  factory NewestLead.fromJson(Map<String, dynamic> json) {
    return NewestLead(
      id: json['id'] ?? '',
      leadTitle: json['leadTitle'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'leadTitle': leadTitle,
    'createdAt': createdAt,
  };
}
