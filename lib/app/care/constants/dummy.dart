import '../../data/network/dashboard/model/dashboard_lead.dart';

class DummyData {
  static LeadAggregationResponse dummyLeadAggregationResponse =
      LeadAggregationResponse(
        success: true,
        message: Message(
          aggregations: Aggregations(
            byStage: [
              StageAggregation(
                stage: "IG7KeXPJVu3l37ti68hgvIJ",
                stageName: "New Lead",
                leadCount: 1,
              ),
              StageAggregation(
                stage: "K9mJlFUJE6kraXJin4ERfBx",
                stageName: "MQL",
                leadCount: 1,
              ),
            ],
            byStatus: [
              StatusAggregation(
                status: "aiAbtAHPPKa0zmMwKHYHaju",
                statusName: "Pending",
                leadCount: 2,
              ),
            ],
            bySource: [
              SourceAggregation(
                source: "17z6eCLlgIkRBjM1L2bhBlf",
                sourceName: "jkhjkh",
                leadCount: 2,
              ),
            ],
            byInterestLevel: [
              InterestLevelAggregation(interestLevel: "high", leadCount: 6),
              InterestLevelAggregation(interestLevel: "medium", leadCount: 3),
            ],
          ),
          metadata: Metadata(
            totalLeads: 2,
            newestLead: NewestLead(
              id: "jfCarpbWf2DgHk27cjCTopB",
              leadTitle: "fghfgh",
              createdAt: "2025-07-21T09:32:29.000Z",
            ),
          ),
        ),
        data: null,
      );
}
