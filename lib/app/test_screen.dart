import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/data/network/all/project/activity/activitie_model.dart';
import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_call_model.dart';
import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_meeting_model.dart';
import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_task_model.dart';
import 'package:crm_flutter/app/data/network/all/project/members/member_model.dart';
import 'package:crm_flutter/app/data/network/all/project/notes/note_model.dart';
import 'package:crm_flutter/app/modules/screens/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/activity_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/follow_up_call_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/follow_up_meeting_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/follow_up_task_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_card.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      MemberCard(
        member: MemberModel(
          id: "id",
          employeeId: "employeeId",
          username: "username",
          password: "password",
          email: "email",
          roleId: "roleId",
          profilePic: "profilePic",
          firstName: "firstName",
          lastName: "lastName",
          phoneCode: "phoneCode",
          phone: "phone",
          currency: "currency",
          address: "address",
          state: "state",
          city: "city",
          country: "country",
          zipcode: "zipcode",
          website: "website",
          gender: "gender",
          joiningDate: "joiningDate",
          leaveDate: "leaveDate",
          branch: "branch",
          department: "department",
          designation: "designation",
          salary: "salary",
          accountHolder: "accountHolder",
          accountNumber: "accountNumber",
          bankName: "bankName",
          ifsc: "ifsc",
          gstIn: "gstIn",
          bankLocation: "bankLocation",
          cvPath: "cvPath",
          links: "links",
          eSignature: "eSignature",
          accountType: "accountType",
          clientId: "clientId",
          clientPlanId: "clientPlanId",
          documents: "documents",
          resetPasswordOTP: "resetPasswordOTP",
          resetPasswordOTPExpiry: "resetPasswordOTPExpiry",
          storageLimit: "storageLimit",
          storageUsed: "storageUsed",
          createdBy: "createdBy",
          updatedBy: "updatedBy",
          createdAt: "createdAt",
          updatedAt: "updatedAt",
        ),
      ),
      ActivityCard(
        activity: ActivityModel(
          id: "id",
          relatedId: "relatedId",
          activityFrom: "activityFrom",
          activityId: "activityId",
          action: "action",
          performedBy: "performedBy",
          activityMessage: "activityMessage",
          clientId: "clientId",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ),
      NoteCard(
        note: NoteModel(
          id: "id",
          relatedId: "relatedId",
          noteTitle: "noteTitle",
          noteType: "noteType",
          employees: ["employees", "employees"],
          description: "description",
          clientId: "clientId",
          createdBy: "createdBy",
          updatedBy: "updatedBy",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ),
      FileCard(
        file: FileModel(
          url:
              "https://crmmediabucket.s3.amazonaws.com/GREWOX%20CRM/clients/test/deal-files/2025-05/deal-files_rZcWXUhNYpPN1jhLfz0PiX3.png",
          filename: "app_logo.png",
        ),
      ),
      FollowUpTaskCard(
        call: FollowUpTaskModel(
          id: "id",
          subject: "subject",
          dueDate: "dueDate",
          priority: "priority",
          taskReporter: "taskReporter",
          assignedTo: ["assignedTo"],
          status: "status",
          description: "description",
          relatedId: "relatedId",
          clientId: "clientId",
          createdBy: "createdBy",
          updatedBy: "updatedBy",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ),
      FollowUpMeetingCard(
        meeting: FollowUpMeetingModel(
          id: "id",
          title: "title",
          meetingType: "meetingType",
          meetingStatus: "meetingStatus",
          venue: "venue",
          location: "location",
          meetingLink: "meetingLink",
          fromDate: "fromDate",
          fromTime: "fromTime",
          toDate: "toDate",
          toTime: "toTime",
          host: "host",
          assignedTo: ["assignedTo"],
          participantsReminder: "participantsReminder",
          priority: "priority",
          relatedId: "relatedId",
          clientId: "clientId",
          createdBy: "createdBy",
          updatedBy: "updatedBy",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ),
      FollowUpCallCard(
        call: FollowUpCallModel(
          id: "id",
          subject: "subject",
          callStartDate: "callStartDate",
          callStartTime: "callStartTime",
          callEndTime: "callEndTime",
          callDuration: "callDuration",
          assignedTo: ["assignedTo"],
          callPurpose: "callPurpose",
          callReminder: "callReminder",
          callNotes: "callNotes",
          callType: "callType",
          callStatus: "callStatus",
          priority: "priority",
          relatedId: "relatedId",
          clientId: "clientId",
          createdBy: "createdBy",
          updatedBy: "updatedBy",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ),
    ];

    return Scaffold(
      body: ViewScreen(
        itemCount: items.length,
        itemBuilder: (context, i) => items[i],
      ),
    );
  }
}
