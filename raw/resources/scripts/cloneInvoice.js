(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloCloneInvoice Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Tiago Bittencourt Leal <tiago.leal@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloCloneInvoice = function FieloCloneInvoice(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloCloneInvoice = FieloCloneInvoice;

  // Properties
  FieloCloneInvoice.prototype.Constant_ = {
    PAGE_URL: 'data-page-url',
    RECORD_ID: 'data-record-id'
  };

  /**
   * Inicializa el elemento
   */
  FieloCloneInvoice.prototype.init = function() {
    if (this.element_) {
      this.pageUrl = this.element_
        .getAttribute(this.Constant_.PAGE_URL);
      this.recordId = this.element_
        .getAttribute(this.Constant_.RECORD_ID);
      this.element_
        .setAttribute('href',
          this.pageUrl +
          this.recordId
        );
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloCloneInvoice,
    classAsString: 'FieloCloneInvoice',
    cssClass: 'cms-prp-cloneinvoice-button',
    widget: true
  });
})();
