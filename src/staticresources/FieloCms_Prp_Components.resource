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
	  },
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__DefaultFields__c": "Name", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.InvoiceUpload", 
		"FieloCMS__ExcludeFields__c": "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "", 
		"FieloCMS__RecordType__c": "Widget", 
		"FieloCMS__Subcomponents__c": "", 
		"FieloCMS__Visibility__c": "Private", 
		"FieloCMS__sObject__c": "FieloPRP__Invoice__c", 
		"Name": "Invoice Upload"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.ViewInterface", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "FieloCMS.ViewInterface", 
		"FieloCMS__DefaultFields__c": "FieloPRP__Quantity__c,FieloPRP__Product__c,FieloPRP__UnitPrice__c,FieloPRP__TotalPrice__c", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.InvoiceItemRecord", 
		"FieloCMS__ExcludeFields__c": "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "View;Edit", 
		"FieloCMS__RecordType__c": "Record", 
		"FieloCMS__Subcomponents__c": "", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "FieloPRP__InvoiceItem__c", 
		"Name": "Invoice Item Record"
	  }, 
	  {
		"FieloCMS__ControlClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__CssClasses__c": "", 
		"FieloCMS__DataClass__c": "FieloCMS.StandardAPI", 
		"FieloCMS__DefaultFields__c": "Name,Family,IsActive,ProductCode", 
		"FieloCMS__DeveloperName__c": "PrpPlugin.ProductList", 
		"FieloCMS__ExcludeFields__c": "Id,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,IsDeleted", 
		"FieloCMS__Icon__c": "fa-puzzle-piece", 
		"FieloCMS__Layouts__c": "Table", 
		"FieloCMS__RecordType__c": "List", 
		"FieloCMS__Subcomponents__c": "", 
		"FieloCMS__Visibility__c": "Both", 
		"FieloCMS__sObject__c": "Product2", 
		"Name": "Product List"
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
    },
	{
      "Name" : "Invoice Upload",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\n  \"pages\" : [ {\n    \"reference\" : \"a0rf4000000Trz3AAC\",\n    \"recordTypeName\" : \"Page\",\n    \"Name\" : \"Invoice Upload\",\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\n    \"sections\" : [ {\n      \"FieloCMS__Order__c\" : 0,\n      \"FieloCMS__Width__c\" : \"12\",\n      \"subsections\" : [ {\n        \"FieloCMS__Order__c\" : 0,\n        \"FieloCMS__Width__c\" : \"12\",\n        \"components\" : [ {\n          \"reference\" : \"a0lf4000000F8LuAAK\",\n          \"recordTypeName\" : \"Widget\",\n          \"componentLibrary\" : \"Invoice Upload\",\n          \"Name\" : \"Invoice Upload\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[  {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Invoice Number\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\n      \\\"type\\\":\\\"STRING\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Amount\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\n      \\\"type\\\":\\\"CURRENCY\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Date\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\n      \\\"type\\\":\\\"DATE\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Description\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\n      \\\"type\\\":\\\"STRING\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Distributor\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\n      \\\"type\\\":\\\"REFERENCE\\\"\\n   }\\n]\\n]\",\n          \"FieloCMS__Layout__c\" : \"View\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 1,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Upload\",\n          \"FieloCMS__Width__c\" : 0,\n          \"CustomDetailParameter__c\" : \"id\",\n          \"SubmitMode__c\" : \"Close\",\n          \"ProductInjectQuery__c\" : \"IsActive = true\"\n        } ]\n      } ]\n    } ]\n  } ]\n}"
    }, {
      "Name" : "Invoice Upload Settings",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\n  \"pages\" : [ {\n    \"reference\" : \"a0rf4000000Ufn8AAC\",\n    \"recordTypeName\" : \"Page\",\n    \"Name\" : \"Invoice Upload Settings\",\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\n    \"sections\" : [ {\n      \"FieloCMS__Order__c\" : 26,\n      \"FieloCMS__Width__c\" : \"12\",\n      \"subsections\" : [ {\n        \"FieloCMS__Order__c\" : 27,\n        \"FieloCMS__Width__c\" : \"12\",\n        \"components\" : [ {\n          \"reference\" : \"a0lf4000000F9eIAAS\",\n          \"recordTypeName\" : \"Record\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceRecord\",\n          \"Name\" : \"Invoice Record\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\\"label\\\":\\\"Invoice Number\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"label\\\":\\\"Amount\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"DATE\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"label\\\":\\\"Date\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Description\\\",\\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"type\\\":\\\"REFERENCE\\\",\\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\\"label\\\":\\\"Distributor\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false}]]\",\n          \"FieloCMS__LayoutMode__c\" : \"Post\",\n          \"FieloCMS__Layout__c\" : \"View\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 1,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Record Src\",\n          \"FieloCMS__Width__c\" : 0,\n          \"HasDetails__c\" : false\n        }, {\n          \"reference\" : \"a0lf4000000F9eNAAS\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceItems\",\n          \"Name\" : \"Invoice Items\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Quantity\\\",\\\"apiName\\\":\\\"FieloPRP__Quantity__c\\\",\\\"type\\\":\\\"DOUBLE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Product\\\",\\\"apiName\\\":\\\"FieloPRP__Product__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Unit Price\\\",\\\"apiName\\\":\\\"FieloPRP__UnitPrice__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Total Price\\\",\\\"apiName\\\":\\\"FieloPRP__TotalPrice__c\\\",\\\"type\\\":\\\"CURRENCY\\\"}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 4,\n          \"FieloCMS__Order__c\" : 2,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Items Src\",\n          \"FieloCMS__Width__c\" : 0,\n          \"HasDetails__c\" : false\n        }, {\n          \"reference\" : \"a0lf4000000F9gNAAS\",\n          \"recordTypeName\" : \"Record\",\n          \"componentLibrary\" : \"Invoice Item Record\",\n          \"Name\" : \"Invoice Item Record\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"DOUBLE\\\",\\\"apiName\\\":\\\"FieloPRP__Quantity__c\\\",\\\"label\\\":\\\"Quantity\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"REFERENCE\\\",\\\"apiName\\\":\\\"FieloPRP__Product__c\\\",\\\"label\\\":\\\"Product\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__UnitPrice__c\\\",\\\"label\\\":\\\"Unit Price\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__TotalPrice__c\\\",\\\"label\\\":\\\"Total Price\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false}]]\",\n          \"FieloCMS__LayoutMode__c\" : \"Form\",\n          \"FieloCMS__Layout__c\" : \"View\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 3,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Item Record Src Std\",\n          \"FieloCMS__Width__c\" : 0,\n          \"HasDetails__c\" : false\n        }, {\n          \"reference\" : \"a0lf4000000FqvMAAS\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"Product List\",\n          \"Name\" : \"Product List\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"Name\\\",\\\"label\\\":\\\"Product Name\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":true},{\\\"type\\\":\\\"PICKLIST\\\",\\\"apiName\\\":\\\"Family\\\",\\\"label\\\":\\\"Product Family\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"ProductCode\\\",\\\"label\\\":\\\"Product Code\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 4,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Product List\",\n          \"FieloCMS__Width__c\" : 0\n        } ]\n      } ]\n    } ]\n  } ]\n}"
    }]
  } ]
}