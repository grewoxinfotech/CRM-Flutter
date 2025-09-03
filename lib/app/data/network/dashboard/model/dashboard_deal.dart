class DealAggregationResponse {
  final bool success;
  final Message? message;
  final dynamic data;

  DealAggregationResponse({required this.success, this.message, this.data});

  factory DealAggregationResponse.fromJson(Map<String, dynamic> json) {
    return DealAggregationResponse(
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
  final List<CategoryAggregation>? byCategory;
  final List<PipelineAggregation>? byPipeline;

  Aggregations({
    this.byStage,
    this.byStatus,
    this.bySource,
    this.byCategory,
    this.byPipeline,
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
      byCategory:
          json['byCategory'] != null
              ? List<CategoryAggregation>.from(
                json['byCategory'].map((x) => CategoryAggregation.fromJson(x)),
              )
              : null,
      byPipeline:
          json['byPipeline'] != null
              ? List<PipelineAggregation>.from(
                json['byPipeline'].map((x) => PipelineAggregation.fromJson(x)),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'byStage': byStage?.map((x) => x.toJson()).toList(),
    'byStatus': byStatus?.map((x) => x.toJson()).toList(),
    'bySource': bySource?.map((x) => x.toJson()).toList(),
    'byCategory': byCategory?.map((x) => x.toJson()).toList(),
    'byPipeline': byPipeline?.map((x) => x.toJson()).toList(),
  };
}

class StageAggregation {
  final String stage;
  final String stageName;
  final int dealCount;

  StageAggregation({
    required this.stage,
    required this.stageName,
    required this.dealCount,
  });

  factory StageAggregation.fromJson(Map<String, dynamic> json) {
    return StageAggregation(
      stage: json['stage'] ?? '',
      stageName: json['stageName'] ?? '',
      dealCount: json['dealCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'stage': stage,
    'stageName': stageName,
    'dealCount': dealCount,
  };
}

class StatusAggregation {
  final String status;
  final int dealCount;

  StatusAggregation({required this.status, required this.dealCount});

  factory StatusAggregation.fromJson(Map<String, dynamic> json) {
    return StatusAggregation(
      status: json['status'] ?? '',
      dealCount: json['dealCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'dealCount': dealCount};
}

class SourceAggregation {
  final String source;
  final String sourceName;
  final int dealCount;

  SourceAggregation({
    required this.source,
    required this.sourceName,
    required this.dealCount,
  });

  factory SourceAggregation.fromJson(Map<String, dynamic> json) {
    return SourceAggregation(
      source: json['source'] ?? '',
      sourceName: json['sourceName'] ?? '',
      dealCount: json['dealCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'source': source,
    'sourceName': sourceName,
    'dealCount': dealCount,
  };
}

class CategoryAggregation {
  final String category;
  final String categoryName;
  final int dealCount;

  CategoryAggregation({
    required this.category,
    required this.categoryName,
    required this.dealCount,
  });

  factory CategoryAggregation.fromJson(Map<String, dynamic> json) {
    return CategoryAggregation(
      category: json['category'] ?? '',
      categoryName: json['categoryName'] ?? '',
      dealCount: json['dealCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category,
    'categoryName': categoryName,
    'dealCount': dealCount,
  };
}

class PipelineAggregation {
  final String pipeline;
  final String pipelineName;
  final int dealCount;

  PipelineAggregation({
    required this.pipeline,
    required this.pipelineName,
    required this.dealCount,
  });

  factory PipelineAggregation.fromJson(Map<String, dynamic> json) {
    return PipelineAggregation(
      pipeline: json['pipeline'] ?? '',
      pipelineName: json['pipelineName'] ?? '',
      dealCount: json['dealCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'pipeline': pipeline,
    'pipelineName': pipelineName,
    'dealCount': dealCount,
  };
}

class Metadata {
  final int totalDeals;
  final NewestDeal? newestDeal;

  Metadata({required this.totalDeals, this.newestDeal});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      totalDeals: json['totalDeals'] ?? 0,
      newestDeal:
          json['newestDeal'] != null
              ? NewestDeal.fromJson(json['newestDeal'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalDeals': totalDeals,
    'newestDeal': newestDeal?.toJson(),
  };
}

class NewestDeal {
  final String id;
  final String dealTitle;
  final String createdAt;

  NewestDeal({
    required this.id,
    required this.dealTitle,
    required this.createdAt,
  });

  factory NewestDeal.fromJson(Map<String, dynamic> json) {
    return NewestDeal(
      id: json['id'] ?? '',
      dealTitle: json['dealTitle'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'dealTitle': dealTitle,
    'createdAt': createdAt,
  };
}
