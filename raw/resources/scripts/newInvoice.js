(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloNewInvoiceButton Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Tiago Leal <tiago.leal@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloNewInvoiceButton = function FieloNewInvoiceButton(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloNewInvoiceButton = FieloNewInvoiceButton;

  // Properties

  /**
   * Guarda las constantes en un lugar para que sean facilmente actualizadas
   * @enum {string | number}
   * @private
   */
  FieloNewInvoiceButton.prototype.Constant_ = {
    PAGE_ATTRIBUTE: 'data-redirect-page'

  };

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloNewInvoiceButton.prototype.CssClasses_ = {
    NEW: 'fielo-button__new-invoice'

  };

  /**
   * Inicializa el elemento
   */
  FieloNewInvoiceButton.prototype.init = function() {
    if (this.element_) {
      
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloNewInvoiceButton,
    classAsString: 'FieloNewInvoiceButton',
    cssClass: 'cms-prp-new-invoice',
    widget: true
  });
})();
