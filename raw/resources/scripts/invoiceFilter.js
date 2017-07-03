(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloInvoiceFilter Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Alejandro Spinelli <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloInvoiceFilter = function FieloInvoiceFilter(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloInvoiceFilter = FieloInvoiceFilter;

  // Properties

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloInvoiceFilter.prototype.CssClasses_ = {
    AGREE: 'cms-prp-invoice__checkbox',
    HIDE: 'slds-hide',
    SUBMIT: 'fielo-button__submit'
  };

  /**
   * Inicializa el elemento
   */
  FieloInvoiceFilter.prototype.init = function() {
    if (this.element_) {
      console.log('Hello World!');
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloInvoiceFilter,
    classAsString: 'FieloInvoiceFilter',
    cssClass: 'cms-prp-invoice-filter',
    widget: true
  });
})();
