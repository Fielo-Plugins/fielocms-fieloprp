(function() {
  'use strict';

  var FieloFormInvoice = function FieloFormInvoice(element) {
    this.element_ = element;
    // Initialize instance.
    this.init();
  };
  window.FieloFormInvoice = FieloFormInvoice;

  /**
   * Guarda las constantes en un lugar para que sean facilmente actualizadas
   * @enum {string | number}
   * @private
   */
  FieloFormInvoice.prototype.Constant_ = {
    SUBMIT_METHOD: 'FormInvoiceAPI.submit'

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
    ITEMS: 'cms-prp-invoice-items',
    ATTACHMENTS: 'cms-prp-multifileuploader',
    SUBMIT: 'fielo-button__submit'

  };

  FieloFormInvoice.prototype.submit = function() {
    this.getValues();
    Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
      this.Constant_.SUBMIT_METHOD,
      this.invoiceObject,
      this.invoiceItems ? this.invoiceItems : null,
      [{}],
      this.submitCallback.bind(this),
      {
        escape: false
      }
    );
  };

  FieloFormInvoice.prototype.submitCallback = function(result) {
    var fileList = this.element_
      .querySelector('.' + this.CssClasses_.ATTACHMENTS)
        .FieloMultiFileUploaderPRP.fileList;
    this.hasAttachments = fileList ?
      Object.keys(fileList).length > 0 :
      false;
    console.log(result);
    if (this.hasAttachments) {
      var invoiceId = result.Id;
      var url = 'FieloCMS__Page?pageId=' +
        this.element_.getAttribute('data-redirect-page') + '&' +
        this.element_.getAttribute('data-parameter-name') + '=' +
        invoiceId;
      window.redirectURL = url;
      this.element_.querySelector('.' + this.CssClasses_.ATTACHMENTS)
        .FieloMultiFileUploaderPRP.uploadFile(invoiceId);
    }
  };

  FieloFormInvoice.prototype.getValues = function() {
    this.fields_ =
      this.element_.querySelector('.' + this.CssClasses_.FIELDSET)
        .querySelectorAll('.' + this.CssClasses_.FIELD);
    this.invoiceObject = {};
    [].forEach.call(this.fields_, function(field) {
      if (field.getAttribute('data-field-name') === 'FieloPRP__Date__c') {
        if (field.querySelector('input').value !== null &&
          field.querySelector('input').value !== undefined &&
          field.querySelector('input').value !== '') {
          this.invoiceObject[field.getAttribute('data-field-name')] =
          new Date(field.querySelector('input').value).getTime();
        }
      } else {
        this.invoiceObject[field.getAttribute('data-field-name')] =
        field.querySelector('input').value;
      }
    }, this);
    this.invoiceItems = this.items.FieloInvoiceItems.get();
    this.attachmentsList =
      this.attachments.FieloMultiFileUploaderPRP.get();
  };

  /**
   * Inicializa el elemento
   */
  FieloFormInvoice.prototype.init = function() {
    if (this.element_) {
      console.log('Behold the Invoice Form!');
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

