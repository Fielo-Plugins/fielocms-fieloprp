(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloInvoiceItems Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Tiago Leal <tiago.leal@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloInvoiceItems = function FieloInvoiceItems(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloInvoiceItems = FieloInvoiceItems;

  // Properties

  /**
   * Guarda las constantes en un lugar para que sean facilmente actualizadas
   * @enum {string | number}
   * @private
   */
  FieloInvoiceItems.prototype.Constant_ = {
    DATA_UPGRADED: 'data-upgraded',
    DATA_CONTROLLER: 'data-controller-element',
    DATA_FIELD_NAME: 'data-field-name',
    OBJECT_TYPE: 'FieloPRP__InvoiceItem__c'

  };

  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloInvoiceItems.prototype.CssClasses_ = {
    DELETE: 'cms-prp-button__remove',
    ITEM_RECORD: 'cms-prp-invoice-item__record',
    NEW: 'cms-prp-new__invoice-item',
    CONTAINER: 'cms-prp-invoice-items__container',
    FIELD_PREFIX: 'fielo-field--is-'
  };

  FieloInvoiceItems.prototype.initItem_ = function(invoiceItem) {
    invoiceItem.deleteBtn_ =
      invoiceItem.getElementsByClassName(this.CssClasses_.DELETE)[0];
    invoiceItem.deleteBtn_.addEventListener(
      'click',
      this.deleteItem_.bind(this, invoiceItem)
    );
    invoiceItem.inputs =
      invoiceItem.querySelectorAll('input');
    [].forEach.call(invoiceItem.inputs, function(input) {
      input.addEventListener(
        'change',
        this.refreshTotalPrice.bind(this)
      );
    }, this);
  };

  FieloInvoiceItems.prototype.refreshTotalPrice = function(event) {
    var row =
      event.srcElement.closest('.' + this.CssClasses_.ITEM_RECORD);
    var updatedField =
      event.srcElement.closest('td').getAttribute('data-field-name');
    var unitPriceFieldElement =
      row.querySelector('[data-field-name="FieloPRP__UnitPrice__c"]');
    var quantityFieldElement =
      row.querySelector('[data-field-name="FieloPRP__Quantity__c"]');
    var totalPriceFieldElement =
      row.querySelector('[data-field-name="FieloPRP__TotalPrice__c"]');

    var unitPriceField = unitPriceFieldElement ?
      unitPriceFieldElement.querySelector('input') :
      null;
    var quantityField = quantityFieldElement ?
      quantityFieldElement.querySelector('input') :
      null;
    var totalPriceField = totalPriceFieldElement ?
      totalPriceFieldElement.querySelector('input') :
      null;

    if (unitPriceField) {
      if (unitPriceField.value === null ||
        unitPriceField.value === undefined ||
        unitPriceField.value === '') {
        unitPriceField.value = 0;
      }
    }
    if (quantityField) {
      if (quantityField.value === null ||
        quantityField.value === undefined ||
        quantityField.value === '') {
        quantityField.value = 0;
      }
    }
    if (totalPriceField) {
      if (totalPriceField.value === null ||
        totalPriceField.value === undefined ||
        totalPriceField.value === '') {
        totalPriceField.value = 0;
      }
    }

    if (totalPriceField && quantityField && unitPriceField) {
      if (updatedField === 'FieloPRP__Quantity__c') {
        totalPriceField.value =
          parseFloat(quantityField.value) *
            parseFloat(unitPriceField.value);
      }
      if (updatedField === 'FieloPRP__UnitPrice__c') {
        totalPriceField.value =
          parseFloat(quantityField.value) *
            parseFloat(unitPriceField.value);
      }
      if (updatedField === 'FieloPRP__TotalPrice__c') {
        unitPriceField.value =
          parseFloat(quantityField.value) > 0.0 ?
          parseFloat(totalPriceField.value) /
            parseFloat(quantityField.value) :
            0;
      }
    }
    this.refreshAmount();
  };

  FieloInvoiceItems.prototype.refreshAmount = function() {
    var invoiceTotalValue = 0;
    var itemTotal;
    [].forEach.call(this.invoiceItems_, function(item) {
      itemTotal = item
        .querySelector('[data-field-name="FieloPRP__TotalPrice__c"]')
          .querySelector('input').value;
      itemTotal = itemTotal !== null &&
        itemTotal !== undefined &&
        itemTotal !== '' ?
        itemTotal :
        0;
      invoiceTotalValue += parseFloat(itemTotal);
    },
      this
    );
    this.amountSpan_ =
      this.element_
        .querySelector('[data-field-name="FieloPRP__Amount__c"]')
          .querySelector('span');
    this.amountSpan_
      .innerHTML = invoiceTotalValue;
  };

  FieloInvoiceItems.prototype.deleteItem_ = function(invoiceItem) {
    if (this.invoiceItems_.length > 1) {
      invoiceItem.parentNode.removeChild(invoiceItem);
    }
    this.invoiceItems_ =
      this.element_.querySelectorAll('.' + this.CssClasses_.ITEM_RECORD);
    this.refreshAmount();
  };

  FieloInvoiceItems.prototype.newinvoiceItem_ = function() {
    var invoiceItem = this.model_.cloneNode(true);
    this.container_.appendChild(invoiceItem);
    this.invoiceItems_ =
        this.element_.querySelectorAll('.' + this.CssClasses_.ITEM_RECORD);
    this.initItem_(invoiceItem);
  };

  FieloInvoiceItems.prototype.get = function() {
    var sObjectList = [];
    [].forEach.call(this.invoiceItems_, function(item) {
      var sObject = {};
      [].forEach.call(item.querySelectorAll('input'), function(input) {
        var sObjectValue = input.value;
        sObject[input.closest('td').getAttribute('data-field-name')] =
            sObjectValue;
      }, this);
      sObjectList.push(sObject);
    }, this);
    return sObjectList;
  };

  /**
   * Inicializa el elemento
   */
  FieloInvoiceItems.prototype.init = function() {
    if (this.element_) {
      this.element_
        .querySelector('table').style.overflowX = 'unset';
      this.container_ =
        this.element_.getElementsByClassName(this.CssClasses_.CONTAINER)[0];
      this.invoiceItems_ =
        this.element_.querySelectorAll('.' + this.CssClasses_.ITEM_RECORD);
      this.model_ =
        this.invoiceItems_[0].cloneNode(true);
      this.newBtn_ =
        document.getElementsByClassName(this.CssClasses_.NEW)[0];

      if (this.newBtn_) {
        this.newBtn_
          .addEventListener('click', this.newinvoiceItem_.bind(this));
      }
      [].forEach.call(this.invoiceItems_, this.initItem_.bind(this));
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloInvoiceItems,
    classAsString: 'FieloInvoiceItems',
    cssClass: 'cms-prp-invoice-items',
    widget: true
  });
})();
