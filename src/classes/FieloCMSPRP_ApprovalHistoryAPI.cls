global without sharing class FieloCMSPRP_ApprovalHistoryAPI implements FieloCMS.DataInterface{
    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        Map<Id,Object> newMapData = new Map<Id,Object>();
        List<FieloPRP__Invoice__c> records = new List<FieloPRP__Invoice__c>();
        
        String recordId = '';
        for (FieloCMS__Component__c c: components) {
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            recordId = ApexPages.CurrentPage().getParameters().get( c.FieloCMS__DetailParameter__c );

            String query = 'SELECT Id,' +
                'TargetObjectid, ' +
                'Status, ' +
                '(select id,actor.name from Workitems), ' +
                '(SELECT Id, StepStatus, Comments,Actor.Name, CreatedDate FROM Steps ORDER BY CreatedDate DESC) ' +//WHERE StepStatus = \'Rejected\'
                'FROM ProcessInstance where TargetObjectId = :recordId ORDER BY CreatedDate DESC';

            List<ProcessInstance> pis = (List<ProcessInstance>)Database.query(query);

            Map<String,String> statusMap = new Map<String,String> {
                'Approved' => 'Approved',
                'Fault' => 'Pending For Approval',
                'Held' => 'Pending For Approval',
                'NoResponse' => 'Pending For Approval',
                'Pending' => 'Pending For Approval',
                'Reassigned' => 'Pending For Approval',
                'Rejected' => 'Rejected',
                'Removed' => 'Pending For Approval',
                'Started' => 'Pending For Approval'
            };

            if (!pis.isEmpty()) {
	            for(ProcessInstance pi: pis){
	                if (pi.Steps != null) {
	                    if (!pi.Steps.isEmpty()) {
	                        for (ProcessInstanceStep step: pi.Steps) {
	                            records.add(new FieloPRP__Invoice__c(FieloPRP__Status__c = statusMap.get(step.StepStatus),FieloPRP__Comments__c = step.Comments));
	                        }
	                    }
	                }
	            }
            } else {
            	List<FieloPRP__Invoice__c> invoices = Database.query('SELECT Id, FieloPRP__Status__c, FieloPRP__RejectReason__c, FieloPRP__Comments__c FROM FieloPRP__Invoice__c WHERE Id = :recordId');
            	if (invoices[0].FieloPRP__Status__c == 'Approved' || invoices[0].FieloPRP__Status__c == 'Rejected') {
					records.add(invoices[0]);
            	}
            }
            newMapData.put(c.Id,(Object) records);
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }
}
