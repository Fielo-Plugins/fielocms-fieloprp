public class FieloCMSPRP_FileService {
	public static List<sObject> getFiles(Id parentId, Set<String> fields, Integer pageNumber, Integer numberOfRecords, String attachmentFilter, String fileFilter) {
		Set<String> whereStatements = new Set<String>();

		// ATTACHMENTS
		if (parentId != null) {
			whereStatements.add('ParentId = \'' + parentId + '\'');
		}
		if (attachmentFilter != null && attachmentFilter != '') {
			whereStatements.add(attachmentFilter);
		}

		Set<String> attachmentFields = new Set<String>();

		for (String field:fields) {
			if (documentToAttachmentMap.containsKey(field)) {
				attachmentFields.add(documentToAttachmentMap.get(field));
			}
		}
		if (attachmentFields.isEmpty()) {
			attachmentFields.add('Id');
		}

		String query = 'SELECT ' +
			String.join(new List<String>(attachmentFields),',') +
			' FROM Attachment WHERE ' +
			String.join(new List<String>(whereStatements), ' AND ');

		System.debug('### Attachments Query: ' + query);

		List<Attachment> attachments = Database.query(query);

		List<sObject> records = new List<sObject>();

		String attachmentURL = URL.getSalesforceBaseUrl().toExternalForm();
	    if (!Test.isRunningTest()) {
	        attachmentURL += Site.getPathPrefix();
	    }
	    attachmentURL += '/servlet/servlet.FileDownload?file=';
	    attachmentURL += '{0}'; //attachment.Id;
	    attachmentURL += '&oid=';
	    attachmentURL += '{1}'; //UserInfo.getOrganizationId()

	    Map<String,Object> record;
		if (!attachments.isEmpty()) {
			for (Attachment a: attachments) {
				record = new Map<String,Object>();
				for (String fieldName: a.getPopulatedFieldsAsMap().keySet()) {
					if (attachmentToDocumentMap.containsKey(fieldName)) {
						record.put(attachmentToDocumentMap.get(fieldName), a.get(fieldName));
					}
				}
                record.put('Description', String.format(attachmentURL, new List<String>{a.Id,UserInfo.getOrganizationId()}));
				records.add((sObject)JSON.deserialize(JSON.serialize(record), ContentDocument.class));
			}
		}

		// FILES
		whereStatements = new Set<String>();

		if (parentId != null) {
			whereStatements.add('LinkedEntityId = \'' + parentId + '\'');
		}
		if (fileFilter != null && fileFilter != '') {
			whereStatements.add(fileFilter);
		}

		Set<String> documentFields = new Set<String>();
		for (String field:fields) {
			documentFields.add('ContentDocument.' + field);
		}
		if (documentFields.isEmpty()) {
			documentFields.add('ContentDocument.Id');
		}

		query = 'SELECT ' +
			String.join(new List<String>(documentFields), ',') +
			' FROM ContentDocumentLink WHERE ' + 
			String.join(new List<String>(whereStatements), ' AND ');

		System.debug('### Files Query: ' + query);

		List<ContentDocumentLink> cdls = Database.query(query);

		Set<Id> documentIds = new Set<Id>();

		for (ContentDocumentLink cdl:cdls) {
			documentIds.add(cdl.ContentDocument.Id);
		}

		Map<Id,ContentDocument> cdMap = new Map<Id,ContentDocument>((List<ContentDocument>)Database.query('SELECT Id, (Select Id From ContentVersions ORDER BY CreatedDate DESC LIMIT 1) FROM ContentDocument WHERE Id in :documentIds'));

		attachmentURL = URL.getSalesforceBaseUrl().toExternalForm();
		if (!Test.isRunningTest()) {
			attachmentURL += Site.getPathPrefix();
		}
		attachmentURL += '/sfc/servlet.shepherd/version/download/';
		attachmentURL += '{0}'; // cdMap.get(cd.Id).ContentVersions[0].Id;
		for (ContentDocumentLink cdl: cdls) {
			cdl.ContentDocument.Description = String.format(attachmentURL, new LIST<String> {cdMap.get(cdl.ContentDocument.Id).ContentVersions[0].Id});
        	records.add((sObject)cdl.ContentDocument);
        }
        
        List<sObject> outputRows = new List<sObject>();
        Integer offset = Integer.valueOf(numberOfRecords * (pageNumber - 1));
        if (offset < records.size()) {
        	Integer max = offset + numberOfRecords < records.size() ? offset + numberOfRecords : records.size();
        	for (Integer i = offset; i <= max - 1; i++) {
        		outputRows.add(records[i]);
        	}
        }

        return outputRows;
	}

	public static Map<String, String> documentToAttachmentMap {get{
		if (documentToAttachmentMap == null) {
			documentToAttachmentMap = new Map<String, String>{
				'Id' => 'Id',
				'Description' => 'Description',
				'ContentSize' => 'BodyLength',
				'FileExtension' => 'ContentType',
				'FileType' => 'ContentType',
				'OwnerId' => 'OwnerId',
				'ParentId' => 'ParentId',
				'Title' => 'Name'
			};
		}
		return documentToAttachmentMap;
	}
		set;
	}

	public static Map<String, String> attachmentToDocumentMap {get{
		if (attachmentToDocumentMap == null) {
			attachmentToDocumentMap = new Map<String, String>{
				'Id' => 'Id',
				'Description' => 'Description',
				'BodyLength' => 'ContentSize',
				'ContentType' => 'FileExtension',
				'ContentType' => 'FileType',
				'OwnerId' => 'OwnerId',
				'ParentId' => 'ParentId',
				'Name' => 'Title'
			};
		}
		return attachmentToDocumentMap;
	}
		set;
	}

	public static void cloneFiles(Id parentId, Set<Id> fileIds) {
		List<Schema.DescribeSObjectResult> describes = Schema.describeSObjects(new String[]{'Attachment','ContentDocument'}); //[0].getDescribe().getKeyPrefix();
        String attachmentPrefix;
        String contentDocumentPrefix;
        for (Schema.DescribeSObjectResult d: describes) {
          	if(d.getName()=='Attachment') {
            	attachmentPrefix = d.getKeyPrefix();
          	}
          	if(d.getName()=='ContentDocument') {
	            contentDocumentPrefix = d.getKeyPrefix();
          	}
        }

        Set<Id> attachmentIdsSet = new Set<Id>();
        Set<Id> documentIdsSet = new Set<Id>();

        for(String singleId: fileIds) {
            if (singleId.substring(0,3).equals(attachmentPrefix)) {
                attachmentIdsSet.add(singleId);
            }
            if (singleId.substring(0,3).equals(contentDocumentPrefix)) {
                documentIdsSet.add(singleId);
            }
        }

        if (!attachmentIdsSet.isEmpty()) {
        	createDocumentFromAttachment(parentId, attachmentIdsSet);
        }

        if (!documentIdsSet.isEmpty()) {
        	cloneDocuments(parentId, documentIdsSet);
        }
	}

	public static void createDocumentFromAttachment(Id parentId, Set<Id> attachmentIds) {
		Map<Id,Attachment> attachmentMap = new Map<Id,Attachment>((List<Attachment>)Database.query('SELECT Id, Name, Body, ParentId FROM Attachment WHERE Id IN :attachmentIds'));
		List<ContentVersion> cvs = new List<ContentVersion>();

		if (!attachmentMap.isEmpty()) {
			ContentVersion cv;
			for (Attachment a: attachmentMap.values()) {
				cv = new ContentVersion();
		        if (Schema.sObjectType.ContentVersion.fields.Title.isCreateable()) {
		            cv.Title = a.Name;
		        }
		        if (Schema.sObjectType.ContentVersion.fields.PathOnClient.isCreateable()) {
		            cv.PathOnClient = a.Name;
		        }
		        if (Schema.sObjectType.ContentVersion.fields.VersionData.isCreateable()) {
		            cv.VersionData = a.Body;
		        }
		        if (Schema.sObjectType.ContentVersion.fields.IsMajorVersion.isCreateable()) {
		            cv.IsMajorVersion = true;
		        }
		        cvs.add(cv);
			}
			if (!cvs.isEmpty()) {
				insert cvs;
				Map<Id, ContentVersion> cvMap = new Map<Id, ContentVersion>((List<ContentVersion>)Database.query('SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :cvs'));
				
				List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
				ContentDocumentLink cdl;
				for (ContentVersion contentVersion:cvs) {
			        cdl = new ContentDocumentLink();
			        if (Schema.sObjectType.ContentDocumentLink.fields.ContentDocumentId.isCreateable()) {
			            cdl.ContentDocumentId = cvMap.get(contentVersion.Id).ContentDocumentId;
			        }
			        if (Schema.sObjectType.ContentDocumentLink.fields.LinkedEntityId.isCreateable()) {
			            cdl.LinkedEntityId = parentId;
			        }
			        if (Schema.sObjectType.ContentDocumentLink.fields.ShareType.isCreateable()) {
			            cdl.ShareType = 'V';
			        }
			        cdls.add(cdl);
				}
				if (!cdls.isEmpty()) {
		        	insert cdls;
				}
			}
		}
	}

	public static void cloneDocuments(Id parentId, Set<Id> documentIds) {
		Map<Id, ContentDocument> contentDocumentMap = new Map<Id, ContentDocument>((List<ContentDocument>) Database.query('SELECT Id, (Select Id, Title, PathOnClient, IsMajorVersion FROM ContentVersions ORDER BY CreatedDate DESC LIMIT 1) FROM ContentDocument WHERE Id in :documentIds'));
		Set<Id> contentDocumentIds = contentDocumentMap.keySet();
		Map<Id, ContentVersion> existingCVS = new Map<Id,ContentVersion>((List<ContentVersion>) Database.query('SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId IN :contentDocumentIds'));
		List<ContentVersion> cvs = new List<ContentVersion>();
		ContentVersion cv;

		for (ContentDocument cd: contentDocumentMap.values()) {
			if (!cd.ContentVersions.isEmpty()) {
				cv = new ContentVersion();
		        if (Schema.sObjectType.ContentVersion.fields.Title.isCreateable()) {
		            cv.Title = cd.ContentVersions[0].Title;
		        }
		        if (Schema.sObjectType.ContentVersion.fields.PathOnClient.isCreateable()) {
		            cv.PathOnClient = cd.ContentVersions[0].PathOnClient;
		        }
		        if (Schema.sObjectType.ContentVersion.fields.VersionData.isCreateable()) {
		            cv.VersionData = existingCVS.get(cd.ContentVersions[0].Id).VersionData;
		        }
		        if (Schema.sObjectType.ContentVersion.fields.IsMajorVersion.isCreateable()) {
		            cv.IsMajorVersion = cd.ContentVersions[0].IsMajorVersion;
		        }
		        cvs.add(cv);
			}
		}
		if (!cvs.isEmpty()) {
			insert cvs;

			Map<Id, ContentVersion> cvMap = new Map<Id, ContentVersion>((List<ContentVersion>) Database.query('SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :cvs'));
			List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
			ContentDocumentLink cdl;

			for (ContentVersion contentVersion:cvs) {
		        cdl = new ContentDocumentLink();
		        if (Schema.sObjectType.ContentDocumentLink.fields.ContentDocumentId.isCreateable()) {
		            cdl.ContentDocumentId = cvMap.get(contentVersion.Id).ContentDocumentId;
		        }
		        if (Schema.sObjectType.ContentDocumentLink.fields.LinkedEntityId.isCreateable()) {
		            cdl.LinkedEntityId = parentId;
		        }
		        if (Schema.sObjectType.ContentDocumentLink.fields.ShareType.isCreateable()) {
		            cdl.ShareType = 'V';
		        }
		        cdls.add(cdl);
			}
			if (!cdls.isEmpty()) {
	        	insert cdls;
			}
		}
	}
}