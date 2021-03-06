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
    DATA_PRODUCT_FIELD: 'data-product-field',
    OBJECT_TYPE: 'FieloPRP__InvoiceItem__c',
    QUERY_RECORDS_METHOD: 'FieloCMSPRP_FormInvoiceCtrl.queryRecords'

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
    PRODUCT_RECORD: 'cms-prp-invoice-item__product-record',
    NEW: 'cms-prp-new__invoice-item',
    ADD: 'cms-prp-add__products',
    MODAL: 'fielo-modal',
    FIELDS_CONTAINER: 'cms-prp-search-fields',
    MODAL_CONTAINER: 'fielo-modal__body-container',
    PRODUCT_SEARCH_MODEL: 'cms-prp-advanced-product-search__model',
    PRODUCT_SEARCH: 'cms-prp-advanced-product-search',
    PRODUCT_CONTAINER: 'cms-prp-product-search-results__container',
    CONTAINER: 'cms-prp-invoice-items__container',
    FIELD_PREFIX: 'fielo-field--is-',
    FIELO_FIELD: 'fielo-field',
    ROW_SELECTOR: 'fielo-field--is-row-selector',
    COL_SELECTOR: 'fielo-field--is-column-selector',
    SEARCH_BUTTON: 'fielo-button__search',
    ADD_PRODUCTS_BUTTON: 'fielo-button__add-products',
    CLOSE_PRODUCTS_BUTTON: 'fielo-button__close-products',
    TABLE_HEADER: 'fielo-table__head',
    AMOUNT_CONTAINER: 'cms-prp-amount__output',
    PRODUCT_PAGINATOR: 'cms-prp-advanced-product-search__paginator',
    LINK_PREVIOUS: 'fielo-link__previous',
    LINK_NEXT: 'fielo-link__next',
    DISABLED: 'disabled',
    LOOKUP: 'fielo-lookup'

  };

  FieloInvoiceItems.prototype.initItem_ = function(invoiceItem, upgrade) {
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

    if (upgrade) {
      invoiceItem.setAttribute('data-upgraded', '');
      componentHandler.upgradeElement(invoiceItem); // eslint-disable-line no-undef
      var childElements = invoiceItem
        .querySelectorAll('[' + this.Constant_.DATA_UPGRADED + ']');
      [].forEach.call(childElements, function(child) {
        child.setAttribute('data-upgraded', '');
        componentHandler.upgradeElement(child); // eslint-disable-line no-undef
      }, this);
    }
  };

  FieloInvoiceItems.prototype.refreshTotalPrice = function(event) {
    if (this.hasAmountFields) {
      var row =
        event.target.closest('.' + this.CssClasses_.ITEM_RECORD);
      var updatedField =
        event.target.closest('td').getAttribute('data-field-name');
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
            (parseFloat(quantityField.value) *
              parseFloat(unitPriceField.value)).toFixed(2);
        }
        if (updatedField === 'FieloPRP__UnitPrice__c') {
          totalPriceField.value =
            (parseFloat(quantityField.value) *
              parseFloat(unitPriceField.value)).toFixed(2);
        }
        if (updatedField === 'FieloPRP__TotalPrice__c') {
          unitPriceField.value =
            (parseFloat(quantityField.value) > 0.0 ?
            parseFloat(totalPriceField.value) /
              parseFloat(quantityField.value) :
              0).toFixed(2);
        }
      }
      this.refreshAmount();
    }
  };

  FieloInvoiceItems.prototype.refreshAmount = function() {
    if (this.hasAmountFields) {
      var invoiceTotalValue = Number(0);
      var itemTotal;
      [].forEach.call(this.invoiceItems_, function(item) {
        itemTotal = item
          .querySelector('[data-field-name="FieloPRP__TotalPrice__c"]')
            .querySelector('input').value;
        itemTotal = isNaN(parseFloat(itemTotal)) ?
          parseFloat(0) :
          parseFloat(itemTotal);
        invoiceTotalValue += Number(parseFloat(itemTotal));
      },
        this
      );
      this.amountSpan_ =
        this.element_
          .querySelector('[data-field-name="FieloPRP__Amount__c"]')
            .querySelector('span');
      this.amountSpan_
        .innerHTML = parseFloat(invoiceTotalValue).toFixed(2);
    }
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
    this.initItem_(invoiceItem, true);
  };

  FieloInvoiceItems.prototype.get = function() {
    var sObjectList = [];
    var sObject;
    var sObjectValue;
    [].forEach.call(this.invoiceItems_, function(item) {
      sObject = {};
      [].forEach.call(item.querySelectorAll('input:not(.disabled)'),
      function(input) {
        if (input.closest('td').getAttribute('data-field-name') ===
          this.productFieldName) {
          sObjectValue = input.getAttribute('data-lookup-id');
          sObject[input.closest('td').getAttribute('data-field-name')] =
            sObjectValue;
        } else {
          sObjectValue = input.value;
          sObject[input.closest('td').getAttribute('data-field-name')] =
            sObjectValue;
        }
      }, this);
      sObjectList.push(sObject);
    }, this);
    return sObjectList;
  };

  FieloInvoiceItems.prototype.openProductsModal = function() {
    this.productBasket = [];
    var modal =
      document.querySelector('.' + this.CssClasses_.MODAL);
    modal.FieloModal.show();
    this.products =
      document
        .querySelector('.' + this.CssClasses_.PRODUCT_SEARCH_MODEL)
          .cloneNode(true);
    this.removeClass(this.products, 'hidden');
    this.removeClass(this.products,
      this.CssClasses_.PRODUCT_SEARCH_MODEL);
    this.addClass(this.products,
      this.CssClasses_.PRODUCT_SEARCH);
    var modalBody = modal
      .querySelector('.' + this.CssClasses_.MODAL_CONTAINER);
    while (modalBody.firstChild) {
      modalBody.removeChild(modalBody.firstChild);
    }
    modalBody.appendChild(this.products);
    this.searchBtn =
      this.products.querySelector('.' + this.CssClasses_.SEARCH_BUTTON);
    this.searchBtn
      .addEventListener('click', this.queryRecords.bind(this));
    this.productModel =
      this.products
        .querySelector('.' + this.CssClasses_.PRODUCT_RECORD)
          .cloneNode(true);
    this.productContainer =
      this.products
        .querySelector('.' +
          this.CssClasses_.PRODUCT_CONTAINER);
    this.initColumnSelector();
    var productRows =
      this.productContainer.querySelectorAll('tr');
    [].forEach.call(productRows, function(row) {
      this.initRowSelector(row);
    }, this);
    this.addProductsBtn_ =
      this.products.querySelector('.' + this.CssClasses_.ADD_PRODUCTS_BUTTON);
    this.addProductsBtn_
      .addEventListener('click', this.addProducts.bind(this));
    this.closeProductsBtn_ =
      this.products.querySelector('.' + this.CssClasses_.CLOSE_PRODUCTS_BUTTON);
    this.closeProductsBtn_
      .addEventListener('click', this.closeModal.bind(this));
    // Paginator Buttons
    this.productPaginator =
      this.products.querySelector('.' + this.CssClasses_.PRODUCT_PAGINATOR);
    this.links_ = {
      previous:
        this.productPaginator
          .querySelector('.' + this.CssClasses_.LINK_PREVIOUS),
      next:
        this.productPaginator.querySelector('.' + this.CssClasses_.LINK_NEXT)
    };
    this.lookupFields =
      this.products
        .querySelectorAll('.' + this.CssClasses_.LOOKUP);
    if (this.lookupFields) {
      [].forEach.call(this.lookupFields, function(lookupField) {
        lookupField.FieloLookup = new FieloLookup(lookupField); // eslint-disable-line no-undef
      }, this);
    }
    this.setLinksListeners_();
    this.linksEnabled = true;
    this.pageNumber = 1;
    this.queryRecords();
  };

  FieloInvoiceItems.prototype.closeModal = function() {
    var modal =
      document.querySelector('.' + this.CssClasses_.MODAL);
    modal.FieloModal.hide();
  };

  FieloInvoiceItems.prototype.getFilter = function() {
    var fieldsContainer = this.products
      .querySelector('.' + this.CssClasses_.FIELDS_CONTAINER);
    this.productFields = fieldsContainer
      .querySelectorAll('.' + this.CssClasses_.FIELO_FIELD);
    this.filter = {};
    this.productFieldList = [];
    var fieldValue;
    [].forEach.call(this.productFields, function(field) {
      fieldValue = field.querySelector('input');
      if (!fieldValue) {
        fieldValue = field.querySelector('select');
      }
      this.filter[field.getAttribute('data-field-name')] =
        fieldValue.value;
      this.productFieldList.push(field.getAttribute('data-field-name'));
    }, this);
  };

  FieloInvoiceItems.prototype.queryRecords = function() {
    fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
    this.getFilter();
    var objectName =
      this.products.getAttribute('data-object-name');
    Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
      this.Constant_.QUERY_RECORDS_METHOD,
      objectName,
      this.productFieldList,
      JSON.stringify(this.filter),
      parseInt(this.element_.getAttribute('data-product-limit'), 10),
      this.pageNumber,
      this.element_.getAttribute('data-product-query'),
      this.element_.getAttribute('data-product-orderby'),
      this.queryRecordsCallback.bind(this),
      {
        escape: false
      }
    );
  };

  FieloInvoiceItems.prototype.queryRecordsCallback = function(result) {
    if (result) {
      while (this.productContainer.firstChild) {
        this.productContainer.removeChild(
          this.productContainer.firstChild);
      }
      if (result.Records) {
        if (result.Records.length > 0) {
          var newProductRow;
          var fieldPtr;
          var fieldSpan;
          [].forEach.call(result.Records, function(row) {
            newProductRow =
              this.productModel.cloneNode(true);

            [].forEach.call(this.productFieldList, function(field) {
              if (Object.keys(row).indexOf(field) === -1) {
                fieldPtr = newProductRow
                  .querySelector('[data-field-name=' + field + ']');
                fieldPtr
                  .querySelector('span').innerHTML =
                    '';
                fieldPtr.querySelector('span')
                  .setAttribute('data-value', '');
              } else {
                fieldPtr = newProductRow
                  .querySelector('[data-field-name=' + field + ']');
                fieldSpan = fieldPtr
                  .querySelector('span');
                if (fieldSpan.getAttribute('data-type') === 'reference') {
                  fieldSpan.innerHTML =
                    row[field.replace('__c', '__r')].Name;
                } else {
                  fieldSpan.innerHTML = row[field];
                }
                fieldSpan
                  .setAttribute('data-value', row[field]);
              }
            }, this);
            newProductRow
              .querySelector('.' + this.CssClasses_.ROW_SELECTOR)
                .setAttribute('data-record-id', row.Id);
            newProductRow
              .querySelector('.' + this.CssClasses_.ROW_SELECTOR)
                .setAttribute('data-record-name', row.Name);
            this.productContainer.appendChild(newProductRow);
            if (Object.keys(this.productBasket).indexOf(row.Id) !== -1) {
              newProductRow
                .querySelector('.' + this.CssClasses_.ROW_SELECTOR)
                  .querySelector('input').checked = true;
            }
            this.initRowSelector(newProductRow);
          }, this);
        }
      }
      this.setLinksStatus_(result.hasNext);
    }
    fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
  };

  FieloInvoiceItems.prototype.setLinksListeners_ = function() {
    this.links_.previous
      .addEventListener('click', this.getPreviousPage_.bind(this));
    this.links_.next
      .addEventListener('click', this.getNextPage_.bind(this));
  };

  FieloInvoiceItems.prototype.setLinksStatus_ = function(hasNext) {
    // link next
    if (hasNext) {
      this.links_.next.classList.remove(this.CssClasses_.DISABLED);
    } else {
      this.links_.next.classList.add(this.CssClasses_.DISABLED);
    }

    // link previous
    if (this.pageNumber === 1) {
      this.links_.previous.classList.add(this.CssClasses_.DISABLED);
    } else {
      this.links_.previous.classList.remove(this.CssClasses_.DISABLED);
    }
  };

  FieloInvoiceItems.prototype.getPreviousPage_ = function() {
    if (!this.links_.previous.classList.contains(this.CssClasses_.DISABLED)) {
      this.pageNumber--;
      this.queryRecords();
    }
  };

  FieloInvoiceItems.prototype.getNextPage_ = function() {
    if (!this.links_.next.classList.contains(this.CssClasses_.DISABLED)) {
      this.pageNumber++;
      this.queryRecords();
    }
  };

  FieloInvoiceItems.prototype.initColumnSelector = function() {
    this.columnSelector =
      this.products.querySelector('.' + this.CssClasses_.COL_SELECTOR)
        .querySelector('input');
    this.columnSelector
      .addEventListener('change', this.changeSelectors.bind(this));
  };

  FieloInvoiceItems.prototype.changeSelectors = function(event) {
    var rowSelectors = this.products
      .querySelectorAll('.' + this.CssClasses_.ROW_SELECTOR);
    [].forEach.call(rowSelectors, function(rowSelector) {
      rowSelector
        .querySelector('input')
          .checked = event.srcElement.checked;
      this.addProductToBascket(rowSelector.querySelector('input'));
    }, this);
  };

  FieloInvoiceItems.prototype.initRowSelector = function(row) {
    var rowSelector =
      row.querySelector('.' + this.CssClasses_.ROW_SELECTOR);
    rowSelector
      .addEventListener('change', this.addProductToBascketProxy.bind(this));
  };

  FieloInvoiceItems.prototype.addProductToBascket = function(input) {
    if (this.productBasket === null ||
      this.productBasket === undefined) {
      this.productBasket = {};
    }
    var field = input.closest('td');
    if (input.checked) {
      this.productBasket[field.getAttribute('data-record-id')] =
        field.getAttribute('data-record-name');
    } else {
      delete this.productBasket[field.getAttribute('data-record-id')];
    }
  };

  FieloInvoiceItems.prototype.addProductToBascketProxy = function(event) {
    this.addProductToBascket(event.srcElement);
  };

  FieloInvoiceItems.prototype.addProducts = function() {
    if (this.productBasket) {
      if (Object.keys(this.productBasket).length > 0) {
        var invoiceItem;
        var productField;
        this.getEmptyInvoiceItems();
        [].forEach.call(Object.keys(this.productBasket), function(productId) {
          if (this.availableSlots.length > 0) {
            invoiceItem = this.availableSlots.pop();
          } else {
            this.newinvoiceItem_();
            invoiceItem = this.invoiceItems_[this.invoiceItems_.length - 1];
          }
          productField = invoiceItem
            .querySelector('[data-field-name="' + this.productFieldName + '"]');
          productField.querySelector('input').value =
            this.productBasket[productId];
          productField.querySelector('input').setAttribute('data-lookup-id',
            productId);
        }, this);
        var modal =
          document.querySelector('.' + this.CssClasses_.MODAL);
        modal.FieloModal.hide();
      } else {
        console.log('No products selected');
      }
    } else {
      console.log('No products selected');
    }
  };

  FieloInvoiceItems.prototype.getEmptyInvoiceItems = function() {
    var product;
    this.availableSlots = [];
    [].forEach.call(
      this.element_.getElementsByClassName(this.CssClasses_.ITEM_RECORD),
      function(element) {
        product =
          element
            .querySelector('[data-field-name="' + this.productFieldName + '"]')
              .querySelector('input').value;
        if (product === null || product === undefined || product === '') {
          this.availableSlots.push(element);
        }
      },
        this
    );
  };

  FieloInvoiceItems.prototype.removeClass = function(element, className) {
    if (element.classList) {
      element.classList.remove(className);
    } else {
      element.className =
        element.className.replace(new RegExp('\b?' + className + '\b?'), '');
    }
  };

  FieloInvoiceItems.prototype.addClass = function(element, className) {
    var classString = element.className;
    var newClass = classString.concat(' ' + className);
    element.className = newClass;
  };

  FieloInvoiceItems.prototype.getHasFields = function() {
    this.tableHeader =
      this.element_.querySelector('.' + this.CssClasses_.TABLE_HEADER);
    this.hasAmountFields = false;
    if (this.tableHeader
        .querySelector('[data-field-name="FieloPRP__Quantity__c"]') &&
      this.tableHeader
        .querySelector('[data-field-name="FieloPRP__UnitPrice__c"]') &&
      this.tableHeader
        .querySelector('[data-field-name="FieloPRP__TotalPrice__c"]')) {
      this.hasAmountFields = true;
    }
    this.hasProductField = false;
    if (this.tableHeader
        .querySelector('[data-field-name="' + this.productFieldName + '"]')) {
      this.hasProductField = true;
    }
    if (this.hasAmountFields === false) {
      this.element_
        .querySelector('.' + this.CssClasses_.AMOUNT_CONTAINER)
          .style.display = 'none';
    }
    if (this.hasProductField === false) {
      this.element_
        .querySelector('.' + this.CssClasses_.ADD)
          .style.display = 'none';
    }
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
      this.addBtn_ =
        document.querySelector('.' + this.CssClasses_.ADD);
      // Disables any calculation if one of the fields is not present
      this.productFieldName =
        this.element_.getAttribute(this.Constant_.DATA_PRODUCT_FIELD);
      this.getHasFields();
      if (this.newBtn_) {
        this.newBtn_
          .addEventListener('click', this.newinvoiceItem_.bind(this));
      }
      if (this.addBtn_) {
        this.addBtn_
          .addEventListener('click', this.openProductsModal.bind(this));
      }
      [].forEach.call(this.invoiceItems_, function(item) {
        this.initItem_(item, false);
      }, this);
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
