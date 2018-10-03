(function() {
  'use strict';

  var FieloFormInvoice = function FieloFormInvoice(element) {
    this.element_ = element;
    // Initialize instance.
    this.init();
  };
  window.FieloFormInvoice = FieloFormInvoice;

  /**
   * Guarda las constantes en un lugar para que sean facilmente actualizadas©
   * @enum {string | number}
   * @private
   */
  FieloFormInvoice.prototype.Constant_ = {
    SUBMIT_METHOD: 'FieloCMSPRP_FormInvoiceCtrl.submit',
    CHANGE_STATUS_METHOD: 'FieloCMSPRP_FormInvoiceCtrl.changeStatus',
    RETRIEVE_METHOD: 'FieloCMSPRP_FormInvoiceCtrl.getInvoice',
    CURRENCY: {
      uk: 'UAH'
    },
    LOCALE: {
      uk: 'ua'
    }

  };

  /**
   * Guarda strings para nombres de clases definidas poPr este componente que
   * son usadas por JavaScript.
   * Esto nos permite cambiarlos solo en un lugar
   * @enum {string}
   * @private
   */
  FieloFormInvoice.prototype.CssClasses_ = {
    FIELDSET: 'cms-prp-invoice-fieldset',
    FIELD: 'fielo-field',
    LOOKUP: 'cms-prp-lookup',
    ITEMS: 'cms-prp-invoice-items',
    ATTACHMENTS: 'cms-prp-multifileuploader',
    SUBMIT: 'fielo-button__submit'

  };

  FieloFormInvoice.prototype.submit = function() {
    this.getValues();
    this.getExistingAttachments();
    if (this.validateAttachments()) {
      try {
        fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
        Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
          this.Constant_.SUBMIT_METHOD,
          this.invoiceObject,
          this.invoiceItems ? this.invoiceItems : null,
          this.existingAttachments.length > 0 ? this.existingAttachments : [],
          this.element_.getAttribute('data-submit-mode'),
          this.submitCallback.bind(this),
          {
            escape: false
          }
        );
      } catch (e) {
        console.log(e);
      }
    }
  };

  FieloFormInvoice.prototype.getExistingAttachments = function() {
    this.existingAttachments = [];
    this.attachmentsComp =
        this.attachments.FieloMultiFileUploaderPRP;
    var fileList = this.attachmentsComp.fileList;
    [].forEach.call(Object.keys(fileList), function(fileIndex) {
      if (!(fileList[fileIndex] instanceof Blob)) {
        this.existingAttachments
          .push({Id: fileList[fileIndex].Id, Name: fileList[fileIndex].Name});
        delete this.attachmentsComp.fileList[fileIndex];
      }
    }, this);
  };

  FieloFormInvoice.prototype.submitCallback = function(result) {
    if (result.status === 'OK') {
      var fileList = this.element_
        .querySelector('.' + this.CssClasses_.ATTACHMENTS)
          .FieloMultiFileUploaderPRP.fileList;
      this.hasAttachments = fileList ?
        Object.keys(fileList).length > 0 :
        false;
      this.submittedInvoice = result.object;
      var url = '/FieloCMS__Page?pageId=' +
        this.element_.getAttribute('data-redirect-page') + '&' +
        this.element_.getAttribute('data-parameter-name') + '=' +
        this.submittedInvoice.Id;
      window.redirectURL = url;
      if (this.hasAttachments) {
        this.element_.querySelector('.' + this.CssClasses_.ATTACHMENTS)
          .FieloMultiFileUploaderPRP.uploadFile(this.submittedInvoice.Id);
      } else {
        this.changeStatus();
      }
    } else {
      if (this.existingAttachments) {
        [].forEach.call(this.existingAttachments, function(attachment) {
          this.attachmentsComp.fileList[attachment.Id] = attachment;
        }, this);
      }
      fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
      this.throwMessage(result.message, '#', 2, 'ERROR');
    }
  };

  FieloFormInvoice.prototype.redirect = function() {
    var result = {message: FrontEndJSSettings.LABELS.InvoiceSavedSuccess}; // eslint-disable-line no-undef
    this.throwMessage(result.message, 'success');
    if (window.redirectURL) {
      result.redirectURL = this.pathPrefix + window.redirectURL;
    }
    location.replace(result.redirectURL);
  };

  FieloFormInvoice.prototype.throwMessage = function(message, redirect, time, type) { // eslint-disable-line max-len
    fieloUtils.message.FieloMessage.clear(); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.addMessages( // eslint-disable-line no-undef
    fieloUtils.site.FieloSite.getLabel( // eslint-disable-line no-undef
      message)
    );
    fieloUtils.message.FieloMessage.setRedirect(redirect, time); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.setType(type); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.show(); // eslint-disable-line no-undef
  };

  FieloFormInvoice.prototype.getValues = function() {
    this.fields_ =
      this.element_.querySelector('.' + this.CssClasses_.FIELDSET)
        .querySelectorAll('.' + this.CssClasses_.FIELD);
    this.invoiceObject = {};
    var fieldInput;
    var fieldValue;
    [].forEach.call(this.fields_, function(field) {
      if (field.getAttribute('data-field-name') === 'FieloPRP__Date__c') {
        fieldInput = field.querySelector('input');
        if (fieldInput.value !== null &&
          fieldInput.value !== undefined &&
          fieldInput.value !== '') {
          if (fieldInput._flatpickr.selectedDates.length > 0) {
            fieldValue = fieldInput._flatpickr.selectedDates[0].valueOf();
            if (fieldInput._flatpickr.config.enableTime) {
              fieldValue -= (new Date().getTimezoneOffset()) * 60000;
              fieldValue += fieloConfig.OFFSET * 60000; // eslint-disable-line no-undef
            } else {
              fieldValue -= (new Date().getTimezoneOffset()) * 60000;
            }
          } else {
            fieldValue = undefined;
          }
          this.invoiceObject[field.getAttribute('data-field-name')] =
            fieldValue;
        }
      } else if (field.getAttribute('data-field-name') ===
        'FieloPRP__Distributor__c') {
        this.invoiceObject[field.getAttribute('data-field-name')] =
        field.querySelector('input').getAttribute('data-lookup-id');
      } else if (field.querySelector('input')) {
        if (field.getAttribute('data-field-name')) {
          if (field.querySelector('input')) {
            this.invoiceObject[field.getAttribute('data-field-name')] =
            field.querySelector('input').value;
          }
        }
      }
    }, this);
    if (this.items) {
      this.invoiceItems = this.items.FieloInvoiceItems.get();
    } else {
      this.invoiceItems = null;
    }
    this.attachmentsList =
      this.attachments.FieloMultiFileUploaderPRP.get();
  };

  FieloFormInvoice.prototype.validateAttachments = function() {
    var hasAttachments = false;
    if (this.attachmentsList) {
      if (this.attachmentsList.length === 0) {
        this.throwMessage(
          FrontEndJSSettings.LABELS.AttachmentsMissing, '#', 2, 'ERROR'); // eslint-disable-line no-undef
        hasAttachments = false;
      } else {
        hasAttachments = true;
      }
    } else {
      this.throwMessage(
        FrontEndJSSettings.LABELS.AttachmentsMissing, '#', 2, 'ERROR'); // eslint-disable-line no-undef
      hasAttachments = false;
    }
    return hasAttachments;
  };

  FieloFormInvoice.prototype.disableSubmit = function(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
    }
  };

  FieloFormInvoice.prototype.retrieve_ = function() {
    this.invoiceFields =
      this.element_.getAttribute('data-invoice-fields');
    this.invoiceItemFields =
      this.element_.getAttribute('data-invoiceitem-fields');
    this.productFields =
      this.element_.getAttribute('data-product-fields');
    try {
      fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
      Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
        this.Constant_.RETRIEVE_METHOD,
        this.invoiceFields,
        this.invoiceItemFields ? this.invoiceItemFields : '',
        this.cloneId_,
        this.retrieveHandler.bind(this),
        {
          escape: false
        }
      );
    } catch (e) {
      console.log(e);
      fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
    }
  };

  FieloFormInvoice.prototype.retrieveHandler = function(result) {
    console.log(result);
    this.fields_ =
      this.element_.querySelector('.' + this.CssClasses_.FIELDSET)
        .querySelectorAll('.' + this.CssClasses_.FIELD);
    var input;
    var type;
    [].forEach.call(this.fields_, function(field) {
      if (result[field.getAttribute('data-field-name')]) {
        if (field.getAttribute('data-field-name') ===
          'FieloPRP__Distributor__c') {
          if (result[field.getAttribute('data-field-name')] !== '' &&
            result[field.getAttribute('data-field-name')] !== null &&
            result[field.getAttribute('data-field-name')] !== undefined) {
            field.querySelector('.cms-prp-lookup').FieloLookupField
              .preQueryById(result[field.getAttribute('data-field-name')]);
          }
        } else if (field.querySelector('input')) {
          if (field.getAttribute('data-field-name')) {
            if (field.querySelector('input')) {
              input = field.querySelector('input');
              type = input.getAttribute('data-type').toLowerCase();
              if (type === 'date' || type === 'datetime') {
                input.value =
                  result[field.getAttribute('data-field-name')];
                if (input.value !== 'undefined' && input.value !== '') {
                  // Parseo los distintos tipos de fechas a UTC
                  var dateValue = fieloUtils.parseDateFromSF(input.value); // eslint-disable-line no-undef

                  if (type.toLowerCase() === 'datetime') {
                    // Agrega perfiles definido en SF
                    dateValue -= fieloConfig.OFFSET * 60000; // eslint-disable-line no-undef
                  }

                  // compenso el new date
                  // Transforma la fecha a un string iso
                  if (typeof input._flatpickr === 'undefined') {
                    var config = {};
                    if (input.value !== '') {
                      config.defaultDate = dateValue.valueOf();
                    }
                    config.dateFormat =
                      fieloUtils.formatDate(fieloUtils.dateFormat); // eslint-disable-line no-undef
                    if (type === 'datetime') {
                      config.dateFormat =
                        fieloUtils.formatDate(fieloUtils.dateTimeFormat); // eslint-disable-line no-undef
                      config.enableTime = true;
                    }
                    flatpickr(input, config); // eslint-disable-line no-undef
                  }
                  input._flatpickr.setDate(dateValue);
                }
              } else {
                field.querySelector('input').value =
                  result[field.getAttribute('data-field-name')];
              }
            }
          }
        }
      }
    }, this);
    if (this.items) {
      this.itemsComp = this.items.FieloInvoiceItems;
      if (this.items.FieloInvoiceItems) {
        this.itemsComp.getEmptyInvoiceItems();
        var invoiceItem;
        var itemField;
        [].forEach.call(result.FieloPRP__InvoiceItems__r, function(item) {
          if (this.availableSlots.length > 0) {
            invoiceItem = this.availableSlots.pop();
          } else {
            this.newinvoiceItem_();
            invoiceItem = this.invoiceItems_[this.invoiceItems_.length - 1];
          }
          [].forEach.call(Object.keys(item), function(field) {
            itemField = invoiceItem
              .querySelector('[data-field-name=' + field + ']');
            if (itemField) {
              if (itemField.querySelector('.cms-prp-lookup')) {
                if (item[field] !== '' && item[field] !== null &&
                  item[field] !== undefined) {
                  itemField.querySelector('.cms-prp-lookup').FieloLookupField
                    .preQueryById(item[field]);
                }
              } else {
                itemField.querySelector('input').value =
                  item[field];
              }
            }
          }, this);
        }, this.itemsComp);
      }
      this.itemsComp.refreshAmount();
    }
    if (this.attachments) {
      this.attachmentsComp =
        this.attachments.FieloMultiFileUploaderPRP;
      if (!this.attachmentsComp.fileList) {
        this.attachmentsComp.fileList = {};
      }
      if (result.Attachments) {
        [].forEach.call(result.Attachments, function(attachment) {
          this.fileList[attachment.Id] =
            {name: attachment.Name, Id: attachment.Id};
          this.addFileRecord(this.fileList[attachment.Id]);
        }, this.attachmentsComp);
      }
      if (result.ContentDocumentLinks) {
        [].forEach.call(result.ContentDocumentLinks, function(cdl) {
          this.fileList[cdl.ContentDocument.Id] =
            {name: cdl.ContentDocument.Title, Id: cdl.ContentDocument.Id};
          this.addFileRecord(this.fileList[cdl.ContentDocument.Id]);
        }, this.attachmentsComp);
      }
    }
    fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
  };

  FieloFormInvoice.prototype.changeStatus = function(callbackOverride) {
    if (this.validateAttachments()) {
      try {
        fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
        Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
          this.Constant_.CHANGE_STATUS_METHOD,
          this.submittedInvoice,
          this.element_.getAttribute('data-submit-mode'),
          callbackOverride ? callbackOverride.bind(this) :
            this.changeStatusCallback.bind(this),
          {
            escape: false
          }
        );
      } catch (e) {
        console.log(e);
      }
    }
  };

  FieloFormInvoice.prototype.changeStatusCallback = function(result) {
    if (result.status === 'OK') {
      if (result.object) {
        if (result.object.Id) {
          this.redirectToInvoice(result.object.Id);
        }
      }
    } else if (result.message) {
      this.throwMessage(result.message, '#', 2);
    }
  };

  FieloFormInvoice.prototype.redirectToInvoice = function(invoiceId) {
    fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
    var result = {message: FrontEndJSSettings.LABELS.InvoiceSavedSuccess, // eslint-disable-line no-undef
      redirectURL: '/' + invoiceId};
    if (window.redirectURL) {
      result.redirectURL = window.redirectURL;
    }
    this.redirectWithMessage(result.message, result.redirectURL, 2);
  };

  FieloFormInvoice.prototype.redirectWithMessage = function(message, redirect, time) { // eslint-disable-line max-len
    fieloUtils.message.FieloMessage.clear(); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.addMessages( // eslint-disable-line no-undef
    fieloUtils.site.FieloSite.getLabel( // eslint-disable-line no-undef
      message)
    );
    fieloUtils.message.FieloMessage.setRedirect(redirect, time); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.show(); // eslint-disable-line no-undef
  };

  /**
   * Inicializa el elemento
   */
  FieloFormInvoice.prototype.init = function() {
    if (this.element_) {
      this.items =
        document.querySelector('.' + this.CssClasses_.ITEMS);
      this.attachments =
        document.querySelector('.' + this.CssClasses_.ATTACHMENTS);
      this.submitBtn =
        this.element_
          .querySelector('.' + this.CssClasses_.SUBMIT);
      this.submitBtn.addEventListener(
        'click',
        this.submit.bind(this)
      );
      this.locale_ =
        this.Constant_.LOCALE[fieloUtils.locale] || 'en'; // eslint-disable-line no-undef
      this.form_ =
        this.element_.querySelector('form');
      this.form_
        .addEventListener('keypress', this.disableSubmit.bind(this));
      this.cloneId_ =
        this.element_.getAttribute('data-clone-id');
      if (this.cloneId_ !== undefined &&
        this.cloneId_ !== null &&
        this.cloneId_ !== '') {
        this.retrieve_();
      }
      this.pathPrefix = '';
      if (FrontEndJSSettings) { // eslint-disable-line no-undef
        if (FrontEndJSSettings.SITE) { // eslint-disable-line no-undef
          if (FrontEndJSSettings.SITE.pathPrefix) { // eslint-disable-line no-undef
            this.pathPrefix = FrontEndJSSettings.SITE.pathPrefix; // eslint-disable-line no-undef
          }
        }
      }
    }
  };

  FieloFormInvoice.prototype.throwMessage = function(message, redirect, time) { // eslint-disable-line max-len
    fieloUtils.message.FieloMessage.clear(); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.addMessages( // eslint-disable-line no-undef
    fieloUtils.site.FieloSite.getLabel( // eslint-disable-line no-undef
      message)
    );
    fieloUtils.message.FieloMessage.setRedirect(redirect, time); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.show(); // eslint-disable-line no-undef
  };

  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloFormInvoice,
    classAsString: 'FieloFormInvoice',
    cssClass: 'cms-prp-invoice-form',
    widget: true
  });
})();
