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
		"FieloCMS__Subcomponents__c": "", 
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
		"FieloCMS__Subcomponents__c": "", 
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
		"FieloCMS__Subcomponents__c": "", 
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
		"FieloCMS__Subcomponents__c": "", 
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
		"FieloCMS__Subcomponents__c": "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"Description\"  } ]", 
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
		"FieloCMS__Subcomponents__c": "", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "Product2", 
		"Name": "Product Record"
	  }
	],
	"models" : [ {
      "Name" : "My Invoices",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\n  \"pages\" : [ {\n    \"reference\" : \"a0rf4000000TlKDAA0\",\n    \"recordTypeName\" : \"Page\",\n    \"Name\" : \"Invoices\",\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\n    \"sections\" : [ {\n      \"FieloCMS__Order__c\" : 20,\n      \"FieloCMS__Width__c\" : \"12\",\n      \"subsections\" : [ {\n        \"FieloCMS__Order__c\" : 21,\n        \"FieloCMS__Width__c\" : \"12\",\n        \"components\" : [ {\n          \"reference\" : \"a0lf4000000DSIlAAO\",\n          \"componentReference\" : \"a0lf4000000DSIqAAO\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.MyInvoices\",\n          \"Name\" : \"My Invoices\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__DetailURL__c\" : \"FieloCMS__Page?pageId=a0rf4000000TlKIAA0\",\n          \"FieloCMS__DetailView__c\" : \"Internal page\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice Number\\\",\\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Amount\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Date\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Description\\\",\\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Distributor\\\",\\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPRP__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 1,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"My Invoices\",\n          \"FieloCMS__Width__c\" : 0\n        } ]\n      } ]\n    } ]\n  } ]\n}"
    }, {
      "Name" : "Invoice Detail",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\r\n  \"pages\" : [ {\r\n    \"reference\" : \"a0rf4000000TlKIAA0\",\r\n    \"recordTypeName\" : \"Page\",\r\n    \"Name\" : \"Invoice Detail\",\r\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\r\n    \"sections\" : [ {\r\n      \"FieloCMS__Order__c\" : 22,\r\n      \"FieloCMS__Width__c\" : \"12\",\r\n      \"subsections\" : [ {\r\n        \"FieloCMS__Order__c\" : 23,\r\n        \"FieloCMS__Width__c\" : \"12\",\r\n        \"components\" : [ {\r\n          \"reference\" : \"a0lf4000000DSIqAAO\",\r\n          \"recordTypeName\" : \"Record\",\r\n          \"componentLibrary\" : \"PrpPlugin.InvoiceRecord\",\r\n          \"Name\" : \"Invoice Record\",\r\n          \"FieloCMS__CSSClasses__c\" : \"fielo-form-view\",\r\n          \"FieloCMS__Columns__c\" : 2,\r\n          \"FieloCMS__Delay__c\" : 2500,\r\n          \"FieloCMS__DetailParameter__c\" : \"id\",\r\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice Number\\\",\\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Amount\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Date\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\\"label\\\":\\\"Description\\\",\\\"showLabel\\\":true},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Distributor\\\",\\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPRP__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"}]]\",\r\n          \"FieloCMS__LayoutMode__c\" : \"Post\",\r\n          \"FieloCMS__Layout__c\" : \"View\",\r\n          \"FieloCMS__Limit__c\" : 6,\r\n          \"FieloCMS__Order__c\" : 1,\r\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\r\n          \"FieloCMS__Rows__c\" : 2,\r\n          \"FieloCMS__Title__c\" : \"Invoice Record\",\r\n          \"FieloCMS__Width__c\" : 0\r\n        }, {\r\n          \"reference\" : \"a0lf4000000DSIvAAO\",\r\n          \"recordTypeName\" : \"List\",\r\n          \"componentLibrary\" : \"PrpPlugin.InvoiceItems\",\r\n          \"Name\" : \"Invoice Items\",\r\n          \"FieloCMS__CSSClasses__c\" : \"cms-prp-invoice-filter\",\r\n          \"FieloCMS__Columns__c\" : 2,\r\n          \"FieloCMS__DetailParameter__c\" : \"id\",\r\n          \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"Name\\\", \\\"label\\\": \\\"Invoice Item\\\", \\\"type\\\": \\\"STRING\\\" , \\\"linkToDetail\\\": false, \\\"orderBy\\\": \\\"disabled\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"FieloPRP__Product__c\\\", \\\"label\\\": \\\"Product\\\", \\\"type\\\": \\\"REFERENCE\\\" , \\\"showLabel\\\": true, \\\"orderBy\\\": \\\"disabled\\\" , \\\"linkToDetail\\\": false},{\\\"type\\\":\\\"DOUBLE\\\",\\\"apiName\\\":\\\"FieloPRP__Quantity__c\\\",\\\"label\\\":\\\"Quantity\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__TotalPrice__c\\\",\\\"label\\\":\\\"Total Price\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__UnitPrice__c\\\",\\\"label\\\":\\\"Unit Price\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false}]]\",\r\n          \"FieloCMS__Layout__c\" : \"Table\",\r\n          \"FieloCMS__Limit__c\" : 6,\r\n          \"FieloCMS__Order__c\" : 2,\r\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\r\n          \"FieloCMS__Rows__c\" : 2,\r\n          \"FieloCMS__Title__c\" : \"Invoice Items\",\r\n          \"FieloCMS__Width__c\" : 0\r\n        }, {\r\n          \"reference\" : \"a0lf4000000DSJ0AAO\",\r\n          \"recordTypeName\" : \"List\",\r\n          \"componentLibrary\" : \"PrpPlugin.Attachments\",\r\n          \"Name\" : \"Attachments\",\r\n          \"FieloCMS__CSSClasses__c\" : \"cms-prp-invoice-filter\",\r\n          \"FieloCMS__Columns__c\" : 2,\r\n          \"FieloCMS__DetailParameter__c\" : \"id\",\r\n          \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"Name\\\", \\\"label\\\": \\\"File Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"showLabel\\\": true, \\\"orderBy\\\": \\\"disabled\\\" , \\\"linkToDetail\\\": false}]]\",\r\n          \"FieloCMS__Layout__c\" : \"Table\",\r\n          \"FieloCMS__Limit__c\" : 4,\r\n          \"FieloCMS__Order__c\" : 3,\r\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\r\n          \"FieloCMS__Rows__c\" : 2,\r\n          \"FieloCMS__Title__c\" : \"Attachments\",\r\n          \"FieloCMS__Width__c\" : 0\r\n        }, {\r\n          \"reference\" : \"a0lf4000000DSJ5AAO\",\r\n          \"recordTypeName\" : \"List\",\r\n          \"componentLibrary\" : \"PrpPlugin.AttachmentsView\",\r\n          \"Name\" : \"Attachments View\",\r\n          \"FieloCMS__CSSClasses__c\" : \"cms-prp-invoice-filter\",\r\n          \"FieloCMS__Columns__c\" : 1,\r\n          \"FieloCMS__DetailParameter__c\" : \"id\",\r\n          \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"ViewImage\\\", \\\"label\\\": \\\"ViewImage\\\", \\\"type\\\": \\\"Subcomponent\\\" , \\\"showLabel\\\": false, \\\"fieldName\\\": \\\"Description\\\" , \\\"reflectionClass\\\": \\\"Subcomponents.ImageView\\\" }]]\",\r\n          \"FieloCMS__Layout__c\" : \"Grid\",\r\n          \"FieloCMS__Limit__c\" : 1,\r\n          \"FieloCMS__Order__c\" : 4,\r\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\r\n          \"FieloCMS__Rows__c\" : 1,\r\n          \"FieloCMS__Title__c\" : \"Attachments View\",\r\n          \"FieloCMS__Width__c\" : 0\r\n        } ]\r\n      } ]\r\n    } ]\r\n  } ]\r\n}"
    } ]
  } ]
}