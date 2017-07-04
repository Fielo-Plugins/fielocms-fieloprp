{
  "plugins" : [ {
    "Name" : "PrpPlugin",
    "components" : [
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "InvoiceAPI", 
		"FieloCMS__DefaultFields__c": "Name,FieloPRP__Amount__c,FieloPRP__Date__c,FieloPRP__Description__c,FieloPRP__Distributor__c,FieloPRP__InvoiceNumber__c,FieloPRP__Status__c", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.MyInvoices", 
		"FieloCMS__ExcludeFields__c": "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "Grid;Table", 
		"FieloCMS__RecordType__c": "List", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "FieloPRP__Invoice__c", 
		"Name": "My Invoices"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "InvoiceItemAPI", 
		"FieloCMS__DefaultFields__c": "FieloPRP__Product__c,FieloPRP__Quantity__c,FieloPRP__TotalPrice__c,FieloPRP__UnitPrice__c", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.InvoiceItems", 
		"FieloCMS__ExcludeFields__c": "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "Grid;Table", 
		"FieloCMS__RecordType__c": "List", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "FieloPRP__InvoiceItem__c", 
		"Name": "Invoice Items"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__DefaultFields__c": "Name,FieloPRP__Amount__c,FieloPRP__Date__c,FieloPRP__Distributor__c,FieloPRP__InvoiceNumber__c,FieloPRP__Status__c", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.InvoiceRecord", 
		"FieloCMS__ExcludeFields__c": "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "View", 
		"FieloCMS__RecordType__c": "Record", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "FieloPRP__Invoice__c", 
		"Name": "Invoice Record"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "AttachmentAPI", 
		"FieloCMS__DefaultFields__c": "Name", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.Attachments", 
		"FieloCMS__ExcludeFields__c": "Id,IsDeleted,OwnerId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "Grid;Slider;Table", 
		"FieloCMS__RecordType__c": "List", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "Attachment", 
		"Name": "Attachments"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "AttachmentAPI", 
		"FieloCMS__DefaultFields__c": "Name,Description", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.AttachmentsView", 
		"FieloCMS__ExcludeFields__c": "Id,IsDeleted,OwnerId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "Grid;Slider;Table", 
		"FieloCMS__RecordType__c": "List", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "Attachment", 
		"Name": "Attachments View"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__DefaultFields__c": "Name,ProductCode,Description,IsActive,Family", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.ProductRecord", 
		"FieloCMS__ExcludeFields__c": "Id,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,IsDeleted", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "View", 
		"FieloCMS__RecordType__c": "Record", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "Product2", 
		"Name": "Product Record"
	  }
	]
  } ]
}