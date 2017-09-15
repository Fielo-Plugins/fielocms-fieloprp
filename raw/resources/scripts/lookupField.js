(function() {
  'use strict';

  /**
   * @description Constructor for the login form
   * FieloLookupField Implements design patterns defined by MDL at
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Tiago Bittencourt Leal <alejandro.spinelli@fielo.com>
   * @author Hugo Gómez Mac Gregor <hugo.gomez@fielo.com>
   * @param {HTMLElement} element - Element to be upgraded
   * @constructor
   */
  var FieloLookupField = function FieloLookupField(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloLookupField = FieloLookupField;

  // Properties
  FieloLookupField.prototype.Constant_ = {
    GET_METHOD: 'FieloCMSPRP_LookupFieldController.getValues',
    FIELD: 'data-lookup-field-name',
    OBJECT: 'data-lookup-object-name'

  };
  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloLookupField.prototype.CssClasses_ = {
    FIELD: 'cms-prp-lookup__field',
    CONTAINER: 'cms-prp-lookup-search-results__container',
    MODEL: 'cms-prp-invoice-item__product-record',
    SEARCH_BUTTON: 'cms-prp-lookup-button',
    LOOKUP_SEARCH: 'cms-prp-lookup-search__model',
    MODAL: 'fielo-modal',
    MODAL_CONTAINER: 'fielo-modal__body-container',
    ROW_SELECTOR: 'cms-prp-lookup-row-selector',
    SEARCH_FIELD_CONTAINER: 'cms-prp-search-fields',
    SEARCH_RECORDS_BUTTON: 'fielo-button__search',
    LINK_PREVIOUS: 'fielo-link__previous',
    LINK_NEXT: 'fielo-link__next',
    DISABLED: 'disabled'
  };

  FieloLookupField.prototype.getValues = function(callback) {
    Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
      this.Constant_.GET_METHOD,
      this.sObjectName,
      this.recordsPerPage,
      this.pageNumber,
      JSON.stringify(this.filter),
      callback,
      {
        escape: false
      }
    );
  };

  FieloLookupField.prototype.getValuesCallback = function(result) {
    this.recordSet = // eslint-disable-line no-undef
      result.Records;
    this.setLinksStatus_(result.hasNext);
    this.renderRecords();
  };

  FieloLookupField.prototype.renderRecords = function() {
    while (this.recordsContainer.firstChild) {
      this.recordsContainer.removeChild(
        this.recordsContainer.firstChild);
    }
    var newRecord;
    [].forEach.call(this.recordSet, function(record) {
      newRecord = this.createRecord(record);
      newRecord.setAttribute('data-record-id', record.Id);
      this.initRecord(newRecord);
      this.recordsContainer.appendChild(newRecord);
    }, this);
  };

  FieloLookupField.prototype.createRecord = function(record) {
    var newRecord = this.recordModel_.cloneNode(true);
    [].forEach.call(Object.keys(record), function(key) {
      if (key === 'Name') {
        newRecord.querySelector(
          '[' + this.Constant_.FIELD + '="' + key + '"]')
            .querySelector('.' + this.CssClasses_.ROW_SELECTOR)
              .innerHTML = record[key];
      } else {
        newRecord.querySelector(
          '[' + this.Constant_.FIELD + '="' + key + '"]')
            .querySelector('span')
              .innerHTML = record[key];
      }
    }, this);
    return newRecord;
  };

  FieloLookupField.prototype.initRecord = function(record) {
    var selector =
      record.querySelector('.' + this.CssClasses_.ROW_SELECTOR);
    selector
      .addEventListener('click', this.pickRecord.bind(this));
  };

  FieloLookupField.prototype.pickRecord = function(event) {
    var record = event.srcElement.closest('tr');
    this.inputField.setAttribute('data-lookup-id',
      record.getAttribute('data-record-id'));
    this.inputField.value =
      record
        .querySelector('[' + this.Constant_.FIELD + '="Name"]')
          .querySelector('a')
            .innerHTML;
    var modal =
      document.querySelector('.' + this.CssClasses_.MODAL);
    modal.FieloModal.hide();
    this.inputField.focus();
  };

  FieloLookupField.prototype.preQuery = function() {
    fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
    this.filter.Name =
      this.inputField.value;
    this.pageNumber = 1;
    this.getValues(this.preQueryCallback.bind(this));
  };

  FieloLookupField.prototype.preQueryCallback = function(result) {
    this.recordSet =
      result.Records;
    if (this.recordSet.length === 1) {
      this.inputField.setAttribute('data-lookup-id',
        this.recordSet[0].Id);
      this.inputField.value =
        this.recordSet[0].Name;
    } else {
      this.inputField
        .setAttribute('data-lookup-id', '');
      this.renderRecords();
      this.showModal();
      this.setLinksStatus_(result.hasNext);
    }
    fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
  };

  FieloLookupField.prototype.showModal = function() {
    var modal =
      document.querySelector('.' + this.CssClasses_.MODAL);
    var modalBody = modal
      .querySelector('.' + this.CssClasses_.MODAL_CONTAINER);
    while (modalBody.firstChild) {
      modalBody.removeChild(modalBody.firstChild);
    }
    this.removeClass(this.lookupSearch, 'hidden');
    modalBody.appendChild(this.lookupSearch);
    modal.FieloModal.show();
  };

  FieloLookupField.prototype.executeSearch = function() {
    this.filter.Name =
      this.lookupSearchInput.value;
    this.pageNumber = 1;
    this.getValues(this.searchCallback.bind(this));
  };

  FieloLookupField.prototype.searchCallback = function(result) {
    while (this.recordsContainer.firstChild) {
      this.recordsContainer.removeChild(
        this.recordsContainer.firstChild);
    }
    this.recordSet =
      result.Records; // eslint-disable-line no-undef

    this.renderRecords();

    this.setLinksStatus_(result.hasNext);
  };

  FieloLookupField.prototype.setLinksStatus_ = function(hasNext) {
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

  FieloLookupField.prototype.getPreviousPage_ = function() {
    if (!this.links_.previous.classList.contains(this.CssClasses_.DISABLED)) {
      this.pageNumber--;
      this.getValues(this.searchCallback.bind(this));
    }
  };

  FieloLookupField.prototype.getNextPage_ = function() {
    if (!this.links_.next.classList.contains(this.CssClasses_.DISABLED)) {
      this.pageNumber++;
      this.getValues(this.searchCallback.bind(this));
    }
  };

  FieloLookupField.prototype.addClass = function(element, className) {
    var classString = element.className;
    var newClass = classString.concat(' ' + className);
    element.className = newClass;
  };

  FieloLookupField.prototype.removeClass = function(element, className) {
    if (element.classList) {
      element.classList.remove(className);
    } else {
      element.className =
        element.className.replace(new RegExp('\b?' + className + '\b?'), '');
    }
  };

  FieloLookupField.prototype.handleLookupBtnClick = function() {
    this.lookupSearchInput.value =
      this.inputField.value;
    this.renderRecords();
    this.showModal();
    if (this.inputField.value !== null &&
      this.inputField.value !== undefined &&
      this.inputField.value !== '') {
      this.executeSearch();
    }
  };

  FieloLookupField.prototype.handleKeyPress = function(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.preQuery();
    }
  };

  FieloLookupField.prototype.setElementListeners_ = function() {
    this.inputField
      .addEventListener('keypress', this.handleKeyPress.bind(this));
    this.lookupBtn
      .addEventListener('click', this.handleLookupBtnClick.bind(this));
    this.lookupSearchBtn
        .addEventListener('click', this.executeSearch.bind(this));
  };

  FieloLookupField.prototype.setLinksListeners_ = function() {
    this.links_.previous
      .addEventListener('click', this.getPreviousPage_.bind(this));
    this.links_.next
      .addEventListener('click', this.getNextPage_.bind(this));
  };

  /**
   * Inicializa el elemento
   */
  FieloLookupField.prototype.init = function() {
    if (this.element_) {
      this.inputField =
        this.element_.querySelector('.' + this.CssClasses_.FIELD);
      this.lookupSearch =
        this.element_
          .querySelector('.' + this.CssClasses_.LOOKUP_SEARCH)
            .cloneNode(true);
      this.recordsContainer =
        this.lookupSearch.querySelector('.' + this.CssClasses_.CONTAINER);
      this.recordModel_ =
        this.element_.querySelector('.' + this.CssClasses_.MODEL);
      this.sObjectName =
        this.inputField.getAttribute(this.Constant_.OBJECT);
      if (this.recordSet === null || // eslint-disable-line no-undef
        this.recordSet === undefined) { // eslint-disable-line no-undef
        this.pageNumber = 1;
        this.recordsPerPage = 10;
        this.filter = {};
        this.getValues(this.getValuesCallback.bind(this)); // eslint-disable-line no-undef
      }
      this.lookupBtn =
        this.element_.querySelector('.' + this.CssClasses_.SEARCH_BUTTON);
      this.lookupSearchInput =
        this.lookupSearch
          .querySelector('.' + this.CssClasses_.SEARCH_FIELD_CONTAINER)
            .querySelector('[' + this.Constant_.FIELD + '="Name"]')
              .querySelector('input');
      this.lookupSearchBtn =
        this.lookupSearch
          .querySelector('.' + this.CssClasses_.SEARCH_RECORDS_BUTTON);

      // Paginator Buttons
      this.links_ = {
        previous:
          this.lookupSearch.querySelector('.' + this.CssClasses_.LINK_PREVIOUS),
        next:
          this.lookupSearch.querySelector('.' + this.CssClasses_.LINK_NEXT)
      };

      // Setup Listeners
      this.setElementListeners_();
      this.setLinksListeners_();
    }
  };

  // El componente se registra por si solo.
  // Asume que el componentHandler esta habilitado en el scope global
  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloLookupField,
    classAsString: 'FieloLookupField',
    cssClass: 'cms-prp-lookup',
    widget: true
  });
})();
