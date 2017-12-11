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
    SUBMIT_METHOD: 'FieloCMSPRP_FormInvoiceCtrl.submit'

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
    if (this.validateAttachments()) {
      try {
        fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
        Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
          this.Constant_.SUBMIT_METHOD,
          this.invoiceObject,
          this.invoiceItems ? this.invoiceItems : null,
          [{}],
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

  FieloFormInvoice.prototype.submitCallback = function(result) {
    if (result.status === 'OK') {
      var fileList = this.element_
        .querySelector('.' + this.CssClasses_.ATTACHMENTS)
          .FieloMultiFileUploaderPRP.fileList;
      this.hasAttachments = fileList ?
        Object.keys(fileList).length > 0 :
        false;
      var invoiceId = result.object.Id;
      var url = '/FieloCMS__Page?pageId=' +
        this.element_.getAttribute('data-redirect-page') + '&' +
        this.element_.getAttribute('data-parameter-name') + '=' +
        invoiceId;
      window.redirectURL = url;
      if (this.hasAttachments) {
        this.element_.querySelector('.' + this.CssClasses_.ATTACHMENTS)
          .FieloMultiFileUploaderPRP.uploadFile(invoiceId);
      } else {
        this.redirect();
      }
    } else {
      fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
      this.throwMessage(result.message, '#', 2, 'ERROR');
    }
  };

  FieloFormInvoice.prototype.redirect = function() {
    var result = {message: FrontEndJSSettings.LABELS.InvoiceSavedSuccess}; // eslint-disable-line no-undef
    this.throwMessage(result.message, 'success');
    if (window.redirectURL) {
      result.redirectURL = window.redirectURL;
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
              fieldValue += (new Date().getTimezoneOffset()) * 60000;
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
      this.form_ =
        this.element_.querySelector('form');
      this.form_
        .addEventListener('keypress', this.disableSubmit.bind(this));
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
