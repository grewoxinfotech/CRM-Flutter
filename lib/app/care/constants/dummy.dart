import '../../data/network/dashboard/model/dashboard_lead.dart';

class DummyData {
  // static LeadAggregationResponse dummyLeadAggregationResponse =
  //     LeadAggregationResponse(
  //       success: true,
  //       message: Message(
  //         aggregations: Aggregations(
  //           byStage: [
  //             StageAggregation(
  //               stage: "IG7KeXPJVu3l37ti68hgvIJ",
  //               stageName: "New Lead",
  //               leadCount: 1,
  //             ),
  //             StageAggregation(
  //               stage: "K9mJlFUJE6kraXJin4ERfBx",
  //               stageName: "MQL",
  //               leadCount: 1,
  //             ),
  //           ],
  //           byStatus: [
  //             StatusAggregation(
  //               status: "aiAbtAHPPKa0zmMwKHYHaju",
  //               statusName: "Pending",
  //               leadCount: 2,
  //             ),
  //           ],
  //           bySource: [
  //             SourceAggregation(
  //               source: "17z6eCLlgIkRBjM1L2bhBlf",
  //               sourceName: "jkhjkh",
  //               leadCount: 2,
  //             ),
  //           ],
  //           byInterestLevel: [
  //             InterestLevelAggregation(interestLevel: "high", leadCount: 6),
  //             InterestLevelAggregation(interestLevel: "medium", leadCount: 3),
  //           ],
  //         ),
  //         metadata: Metadata(
  //           totalLeads: 2,
  //           newestLead: NewestLead(
  //             id: "jfCarpbWf2DgHk27cjCTopB",
  //             leadTitle: "fghfgh",
  //             createdAt: "2025-07-21T09:32:29.000Z",
  //           ),
  //         ),
  //       ),
  //       data: null,
  //     );

  static LeadAggregationResponse dummyLeadAggregationResponse =
  LeadAggregationResponse(
    success: true,
    message: Message(
      aggregations: Aggregations(
        byStage: [
          StageAggregation(
            stage: "IG7KeXPJVu3l37ti68hgvIJ",
            stageName: "New Lead",
            leadCount: 15,
          ),
          StageAggregation(
            stage: "K9mJlFUJE6kraXJin4ERfBx",
            stageName: "MQL",
            leadCount: 12,
          ),
          StageAggregation(
            stage: "s7yHnJaa2P9ksdfg345asdw",
            stageName: "SQL",
            leadCount: 9,
          ),
          StageAggregation(
            stage: "u8nPqWeRkLm9bnQpO1xYsdf",
            stageName: "Proposal Sent",
            leadCount: 7,
          ),

          StageAggregation(
            stage: "F2hYxCvLm9pQrT7kLp8sJdf",
            stageName: "Closed Won",
            leadCount: 11,
          ),

        ],
        byStatus: [
          StatusAggregation(
            status: "aiAbtAHPPKa0zmMwKHYHaju",
            statusName: "Pending",
            leadCount: 20,
          ),
          StatusAggregation(
            status: "s9LdFgHjKlQp0xZnM2yRtuv",
            statusName: "Contacted",
            leadCount: 15,
          ),
          StatusAggregation(
            status: "q1WeRtY9uIoPlMk3jHgFdsA",
            statusName: "Qualified",
            leadCount: 10,
          ),
          StatusAggregation(
            status: "z8XcVbNmLoPjKqWe9rTyUio",
            statusName: "Not Interested",
            leadCount: 8,
          ),
          StatusAggregation(
            status: "y7GfTrEwQpLm9NbVcXoAsDf",
            statusName: "Converted",
            leadCount: 6,
          ),
        ],
        bySource: [
          SourceAggregation(
            source: "17z6eCLlgIkRBjM1L2bhBlf",
            sourceName: "Website",
            leadCount: 14,
          ),
          SourceAggregation(
            source: "5vXyZuTnLp9QjR2aSmKfDgh",
            sourceName: "LinkedIn",
            leadCount: 9,
          ),
          SourceAggregation(
            source: "3jKfGhLp9QxWzTuNmErYbvC",
            sourceName: "Facebook",
            leadCount: 12,
          ),
          SourceAggregation(
            source: "1aSdFgHp9QwErT2yUiOpLkZ",
            sourceName: "Google Ads",
            leadCount: 7,
          ),
          SourceAggregation(
            source: "8uIoPlMk9QwErTyGhFjKzXc",
            sourceName: "Referral",
            leadCount: 5,
          ),
        ],
        byInterestLevel: [
          InterestLevelAggregation(interestLevel: "high", leadCount: 22),
          InterestLevelAggregation(interestLevel: "medium", leadCount: 15),
          InterestLevelAggregation(interestLevel: "low", leadCount: 8),
          InterestLevelAggregation(interestLevel: "cold", leadCount: 5),
        ],
      ),
      metadata: Metadata(
        totalLeads: 50,
        newestLead: NewestLead(
          id: "jfCarpbWf2DgHk27cjCTopB",
          leadTitle: "Big Enterprise Deal",
          createdAt: "2025-08-30T15:45:10.000Z",
        ),
      ),
    ),
    data: null,
  );

}
