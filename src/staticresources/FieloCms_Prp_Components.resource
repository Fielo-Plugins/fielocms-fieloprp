
{
  "plugins" : [ {
    "Name" : "PrpPlugin",
    "FieloCMS__Version__c" : 1.03,
    "components" : [ {
      "recordTypeName" : "List",
      "Name" : "Attachments View",
      "FieloCMS__AdditionalFields__c" : "FieloCMSPRP_CustomDetailParameter__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMSPRP_AttachmentAPI",
      "FieloCMS__DefaultFields__c" : "Name,Description",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.AttachmentsView",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,OwnerId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "Grid;Slider;Table",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"Description\"  } ]",
      "FieloCMS__sObject__c" : "Attachment"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Invoice Upload",
      "FieloCMS__AdditionalFields__c" : "FieloCMSPLT_RedirectPage__c,FieloCMSPRP_MainSourceComponent__c,FieloCMSPRP_SecondarySourceComponent__c,FieloCMSPRP_CustomDetailParameter__c,FieloCMSPRP_SubmitMode__c,FieloCMSPRP_HasDetails__c,FieloCMSPRP_ProductSourceComponent__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.InvoiceUpload",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__ViewClass__c" : "FieloCMSPRP_FormInvoiceCtrl",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPRP__Invoice__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Invoice Item Record",
      "FieloCMS__ControlClass__c" : "FieloCMS.ViewInterface",
      "FieloCMS__DataClass__c" : "FieloCMS.ViewInterface",
      "FieloCMS__DefaultFields__c" : "FieloPRP__Quantity__c,FieloPRP__Product__c,FieloPRP__UnitPrice__c,FieloPRP__TotalPrice__c",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.InvoiceItemRecord",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "View;Edit",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__sObject__c" : "FieloPRP__InvoiceItem__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Product List",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name,Family,IsActive,ProductCode",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.ProductList",
      "FieloCMS__ExcludeFields__c" : "Id,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,IsDeleted",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "Table",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__sObject__c" : "Product2"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Invoice Record",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloPRP__Amount__c,FieloPRP__Date__c,FieloPRP__Distributor__c,FieloPRP__InvoiceNumber__c,FieloPRP__Status__c",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.InvoiceRecord",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "View;Edit",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__sObject__c" : "FieloPRP__Invoice__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Attachments",
      "FieloCMS__AdditionalFields__c" : "FieloCMSPRP_CustomDetailParameter__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMSPRP_AttachmentAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.Attachments",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,OwnerId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "Grid;Slider;Table",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__sObject__c" : "Attachment"
    }, {
      "recordTypeName" : "List",
      "Name" : "My Invoices",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMSPRP_InvoiceAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloPRP__Amount__c,FieloPRP__Date__c,FieloPRP__Description__c,FieloPRP__Distributor__c,FieloPRP__InvoiceNumber__c,FieloPRP__Status__c",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.MyInvoices",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "Grid;Table",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__sObject__c" : "FieloPRP__Invoice__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Invoice Items",
      "FieloCMS__AdditionalFields__c" : "FieloCMSPRP_CustomDetailParameter__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMSPRP_InvoiceItemAPI",
      "FieloCMS__DefaultFields__c" : "FieloCMSPRP_ProductName__c,FieloPRP__Quantity__c,FieloPRP__TotalPrice__c,FieloPRP__UnitPrice__c",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.InvoiceItems",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "Grid;Table",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__sObject__c" : "FieloPRP__InvoiceItem__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Filter Invoices",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-filter",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "FieloPRP__Status__c,FieloPRP__Amount__c,FieloPRP__Date__c",
      "FieloCMS__DeveloperName__c" : "PrpPlugin.FilterInvoices",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "fa-puzzle-piece",
      "FieloCMS__Layouts__c" : "Edit",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPRP__Invoice__c"
    } ],
    "models" : [ {
      "Name" : "Invoice Upload Settings",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\n  \"pages\" : [ {\n    \"reference\" : \"a0rf4000000V1WdAAK\",\n    \"recordTypeName\" : \"Page\",\n    \"Name\" : \"Invoice Upload Settings\",\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\n    \"sections\" : [ {\n      \"FieloCMS__Order__c\" : 26,\n      \"FieloCMS__Width__c\" : \"12\",\n      \"subsections\" : [ {\n        \"FieloCMS__Order__c\" : 27,\n        \"FieloCMS__Width__c\" : \"12\",\n        \"components\" : [ {\n          \"reference\" : \"a0lf40000015C6QAAU\",\n          \"recordTypeName\" : \"Record\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceRecord\",\n          \"Name\" : \"Invoice Record\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\\"label\\\":\\\"Invoice Number\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"label\\\":\\\"Amount\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"type\\\":\\\"DATE\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"label\\\":\\\"Date\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Description\\\",\\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"type\\\":\\\"REFERENCE\\\",\\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\\"label\\\":\\\"Distributor\\\",\\\"showLabel\\\":true,\\\"autocomplete\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"inlineHelpText\\\":\\\"\\\",\\\"readOnly\\\":false,\\\"required\\\":false}]]\",\n          \"FieloCMS__LayoutMode__c\" : \"Post\",\n          \"FieloCMS__Layout__c\" : \"View\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 1,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Record Src\",\n          \"FieloCMS__Width__c\" : 0\n        }, {\n          \"reference\" : \"a0lf40000015C6RAAU\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceItems\",\n          \"Name\" : \"Invoice Items\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Quantity\\\",\\\"apiName\\\":\\\"FieloPRP__Quantity__c\\\",\\\"type\\\":\\\"DOUBLE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Product\\\",\\\"apiName\\\":\\\"FieloPRP__Product__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Unit Price\\\",\\\"apiName\\\":\\\"FieloPRP__UnitPrice__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Total Price\\\",\\\"apiName\\\":\\\"FieloPRP__TotalPrice__c\\\",\\\"type\\\":\\\"CURRENCY\\\"}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 4,\n          \"FieloCMS__Order__c\" : 2,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Items Src\",\n          \"FieloCMS__Width__c\" : 0\n        }, {\n          \"reference\" : \"a0lf40000015C6SAAU\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.ProductList\",\n          \"Name\" : \"Product List\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"Name\\\",\\\"label\\\":\\\"Product Name\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":true},{\\\"type\\\":\\\"PICKLIST\\\",\\\"apiName\\\":\\\"Family\\\",\\\"label\\\":\\\"Product Family\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"ProductCode\\\",\\\"label\\\":\\\"Product Code\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 4,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Product List\",\n          \"FieloCMS__Width__c\" : 0\n        } ]\n      } ]\n    } ]\n  } ]\n}"
    }, {
      "Name" : "Invoice Upload",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\n  \"pages\" : [ {\n    \"reference\" : \"a0rf4000000V1WsAAK\",\n    \"recordTypeName\" : \"Page\",\n    \"Name\" : \"Invoice Upload\",\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\n    \"sections\" : [ {\n      \"FieloCMS__Order__c\" : 0,\n      \"FieloCMS__Width__c\" : \"12\",\n      \"subsections\" : [ {\n        \"FieloCMS__Order__c\" : 0,\n        \"FieloCMS__Width__c\" : \"12\",\n        \"components\" : [ {\n          \"reference\" : \"a0lf40000015C6VAAU\",\n          \"recordTypeName\" : \"Widget\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceUpload\",\n          \"Name\" : \"Invoice Upload\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[  {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Invoice Number\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\n      \\\"type\\\":\\\"STRING\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Amount\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\n      \\\"type\\\":\\\"CURRENCY\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Date\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\n      \\\"type\\\":\\\"DATE\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Description\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\n      \\\"type\\\":\\\"STRING\\\"\\n   },\\n   {  \\n      \\\"required\\\":false,\\n      \\\"readOnly\\\":false,\\n      \\\"inlineHelpText\\\":\\\"\\\",\\n      \\\"placeholder\\\":\\\"\\\",\\n      \\\"autocomplete\\\":\\\"\\\",\\n      \\\"showLabel\\\":true,\\n      \\\"label\\\":\\\"Distributor\\\",\\n      \\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\n      \\\"type\\\":\\\"REFERENCE\\\"\\n   }\\n]\\n]\",\n          \"FieloCMS__Layout__c\" : \"View\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 1,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Upload\",\n          \"FieloCMS__Width__c\" : 0,\n          \"FieloCMSPRP_CustomDetailParameter__c\" : \"id\",\n          \"FieloCMSPRP_SubmitMode__c\" : \"Submit\"\n        } ]\n      } ]\n    } ]\n  } ]\n}"
    }, {
      "Name" : "Invoice Detail",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\n  \"pages\" : [ {\n    \"reference\" : \"a0rf4000000V1WYAA0\",\n    \"recordTypeName\" : \"Page\",\n    \"Name\" : \"Invoice Detail\",\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\n    \"sections\" : [ {\n      \"FieloCMS__Order__c\" : 22,\n      \"FieloCMS__Width__c\" : \"12\",\n      \"subsections\" : [ {\n        \"FieloCMS__Order__c\" : 23,\n        \"FieloCMS__Width__c\" : \"12\",\n        \"components\" : [ {\n          \"reference\" : \"a0lf40000015C6LAAU\",\n          \"recordTypeName\" : \"Record\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceRecord\",\n          \"Name\" : \"Invoice Record\",\n          \"FieloCMS__CSSClasses__c\" : \"fielo-form-view\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice Number\\\",\\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Amount\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Date\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\\"label\\\":\\\"Description\\\",\\\"showLabel\\\":true},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Distributor\\\",\\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPRP__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"}]]\",\n          \"FieloCMS__LayoutMode__c\" : \"Post\",\n          \"FieloCMS__Layout__c\" : \"View\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 1,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Record\",\n          \"FieloCMS__Width__c\" : 0\n        }, {\n          \"reference\" : \"a0lf40000015C6MAAU\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.InvoiceItems\",\n          \"Name\" : \"Invoice Items\",\n          \"FieloCMS__CSSClasses__c\" : \"cms-prp-invoice-filter\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"DOUBLE\\\",\\\"apiName\\\":\\\"FieloPRP__Quantity__c\\\",\\\"label\\\":\\\"Quantity\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloCMSPRP_ProductName__c\\\",\\\"label\\\":\\\"Product Name\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__UnitPrice__c\\\",\\\"label\\\":\\\"Unit Price\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"type\\\":\\\"CURRENCY\\\",\\\"apiName\\\":\\\"FieloPRP__TotalPrice__c\\\",\\\"label\\\":\\\"Total Price\\\",\\\"showLabel\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 6,\n          \"FieloCMS__Order__c\" : 2,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Invoice Items\",\n          \"FieloCMS__Width__c\" : 0,\n          \"FieloCMSPRP_CustomDetailParameter__c\" : \"id\"\n        }, {\n          \"reference\" : \"a0lf40000015C6NAAU\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.Attachments\",\n          \"Name\" : \"Attachments\",\n          \"FieloCMS__CSSClasses__c\" : \"cms-prp-invoice-filter\",\n          \"FieloCMS__Columns__c\" : 2,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"File Name\\\",\\\"apiName\\\":\\\"Name\\\"}]]\",\n          \"FieloCMS__Layout__c\" : \"Table\",\n          \"FieloCMS__Limit__c\" : 4,\n          \"FieloCMS__Order__c\" : 3,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 2,\n          \"FieloCMS__Title__c\" : \"Attachments\",\n          \"FieloCMS__Width__c\" : 0,\n          \"FieloCMSPRP_CustomDetailParameter__c\" : \"id\"\n        }, {\n          \"reference\" : \"a0lf40000015C6OAAU\",\n          \"recordTypeName\" : \"List\",\n          \"componentLibrary\" : \"PrpPlugin.AttachmentsView\",\n          \"Name\" : \"Attachments View\",\n          \"FieloCMS__CSSClasses__c\" : \"cms-prp-invoice-filter\",\n          \"FieloCMS__Columns__c\" : 1,\n          \"FieloCMS__Delay__c\" : 2500,\n          \"FieloCMS__DetailParameter__c\" : \"id\",\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"reflectionClass\\\":\\\"Subcomponents.ImageView\\\",\\\"fieldName\\\":\\\"Description\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"Subcomponent\\\",\\\"label\\\":\\\"ViewImage\\\",\\\"apiName\\\":\\\"ViewImage\\\"}]]\",\n          \"FieloCMS__Layout__c\" : \"Grid\",\n          \"FieloCMS__Limit__c\" : 3,\n          \"FieloCMS__Order__c\" : 4,\n          \"FieloCMS__ParameterName__c\" : \"paginatorBinding\",\n          \"FieloCMS__Rows__c\" : 3,\n          \"FieloCMS__Title__c\" : \"Attachments View\",\n          \"FieloCMS__Width__c\" : 0,\n          \"FieloCMSPRP_CustomDetailParameter__c\" : \"id\"\n        } ]\n      } ]\n    } ]\n  } ]\n}"
    }, {
      "Name" : "My Invoices",
      "FieloCMS__Category__c" : "Miscelaneas",
      "FieloCMS__Icon__c" : "fielosf-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{\r\n  \"pages\" : [ {\r\n    \"reference\" : \"a0o1I000000LODgQAO\",\r\n    \"recordTypeName\" : \"Page\",\r\n    \"Name\" : \"My Invoices\",\r\n    \"FieloCMS__Icon__c\" : \"fielo-icon-content\",\r\n    \"sections\" : [ {\r\n      \"FieloCMS__Order__c\" : 0,\r\n      \"FieloCMS__Width__c\" : \"12\",\r\n      \"subsections\" : [ {\r\n        \"FieloCMS__Order__c\" : 0,\r\n        \"FieloCMS__Width__c\" : \"12\",\r\n        \"components\" : [ {\r\n          \"reference\" : \"a0i1I000000qN9xQAE\",\r\n          \"recordTypeName\" : \"Record\",\r\n          \"componentLibrary\" : \"PrpPlugin.FilterInvoices\",\r\n          \"Name\" : \"Filter Invoices\",\r\n          \"FieloCMS__Columns__c\" : 2,\r\n          \"FieloCMS__Delay__c\" : 2500,\r\n          \"FieloCMS__DetailParameter__c\" : \"id\",\r\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPRP__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Amount\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Date\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"type\\\":\\\"DATE\\\"}]]\",\r\n          \"FieloCMS__LayoutMode__c\" : \"Form\",\r\n          \"FieloCMS__Layout__c\" : \"Edit\",\r\n          \"FieloCMS__Limit__c\" : 6,\r\n          \"FieloCMS__Order__c\" : 1,\r\n          \"FieloCMS__ParameterName__c\" : \"invoices\",\r\n          \"FieloCMS__Rows__c\" : 2,\r\n          \"FieloCMS__Title__c\" : \"Filter Invoices\",\r\n          \"FieloCMS__Width__c\" : 0\r\n        }, {\r\n          \"reference\" : \"a0i1I000000dDL2QAM\",\r\n          \"componentReference\" : \"a0i1I000000dDL7QAM\",\r\n          \"recordTypeName\" : \"List\",\r\n          \"componentLibrary\" : \"PrpPlugin.MyInvoices\",\r\n          \"Name\" : \"My Invoices\",\r\n          \"FieloCMS__Columns__c\" : 2,\r\n          \"FieloCMS__Delay__c\" : 2500,\r\n          \"FieloCMS__DetailParameter__c\" : \"id\",\r\n          \"FieloCMS__DetailURL__c\" : \"FieloCMS__Page?pageId=a0o1I000000LODlQAO\",\r\n          \"FieloCMS__DetailView__c\" : \"Internal page\",\r\n          \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Invoice Number\\\",\\\"apiName\\\":\\\"FieloPRP__InvoiceNumber__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Amount\\\",\\\"apiName\\\":\\\"FieloPRP__Amount__c\\\",\\\"type\\\":\\\"CURRENCY\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Date\\\",\\\"apiName\\\":\\\"FieloPRP__Date__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Description\\\",\\\"apiName\\\":\\\"FieloPRP__Description__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Distributor\\\",\\\"apiName\\\":\\\"FieloPRP__Distributor__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPRP__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"}]]\",\r\n          \"FieloCMS__Layout__c\" : \"Table\",\r\n          \"FieloCMS__Limit__c\" : 10,\r\n          \"FieloCMS__Order__c\" : 1,\r\n          \"FieloCMS__ParameterName__c\" : \"invoices\",\r\n          \"FieloCMS__Rows__c\" : 2,\r\n          \"FieloCMS__Title__c\" : \"My Invoices\",\r\n          \"FieloCMS__Width__c\" : 0\r\n        } ]\r\n      } ]\r\n    } ]\r\n  } ]\r\n}"
    } ]
  } ]
}