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
    FrontEndJSSettings.LOOKUPS[this.fieldFullName] = // eslint-disable-line no-undef
      result.Records;
    this.setLinksStatus_(result.hasNext);
  };

  FieloLookupField.prototype.renderOptions = function() {
    if (!this.isLoaded) {
      while (this.optionsContainer.firstChild) {
        this.optionsContainer.removeChild(
          this.optionsContainer.firstChild);
      }
      this.options =
        FrontEndJSSettings.LOOKUPS[this.fieldFullName]; // eslint-disable-line no-undef
      var newOption;
      [].forEach.call(this.options, function(option) {
        newOption = this.createOption(option);
        newOption.setAttribute('data-record-id', option.Id);
        this.initOption(newOption);
        this.optionsContainer.appendChild(newOption);
      }, this);
      this.isLoaded = true;
    }
  };

  FieloLookupField.prototype.createOption = function(record) {
    var option = this.optionModel_.cloneNode(true);
    [].forEach.call(Object.keys(record), function(key) {
      if (key === 'Name') {
        option.querySelector(
          '[' + this.Constant_.FIELD + '="' + key + '"]')
            .querySelector('.' + this.CssClasses_.ROW_SELECTOR)
              .innerHTML = record[key];
      } else {
        option.querySelector(
          '[' + this.Constant_.FIELD + '="' + key + '"]')
            .querySelector('span')
              .innerHTML = record[key];
      }
    }, this);
    return option;
  };

  FieloLookupField.prototype.initOption = function(option) {
    var selector =
      option.querySelector('.' + this.CssClasses_.ROW_SELECTOR);
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

  FieloLookupField.prototype.filterItems = function(items, query) {
    return items.filter(function(el) {
      return el.Name.toLowerCase().indexOf(query.toLowerCase()) > -1;
    });
  };

  FieloLookupField.prototype.preQuery = function(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.filter.Name =
        this.inputField.value;
      this.pageNumber = 1;
      this.getValues(this.preQueryCallback.bind(this));
      fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
    }
  };

  FieloLookupField.prototype.preQueryCallback = function(result) {
    var filteredItems =
      result.Records;
    if (filteredItems.length === 1) {
      this.inputField.setAttribute('data-lookup-id',
        filteredItems[0].Id);
      this.inputField.value =
        filteredItems[0].Name;
    } else {
      this.inputField.setAttribute('data-lookup-id',
        '');
      this.showModal();
    }
    fieloUtils.spinner.FieloSpinner.hide(); // eslint-disable-line no-undef
  };

  FieloLookupField.prototype.showModal = function() {
    this.renderOptions();
    this.lookupSearchInput.value =
      this.inputField.value;
    var modal =
      document.querySelector('.' + this.CssClasses_.MODAL);
    var modalBody = modal
      .querySelector('.' + this.CssClasses_.MODAL_CONTAINER);
    while (modalBody.firstChild) {
      modalBody.removeChild(modalBody.firstChild);
    }
    modal.FieloModal.show();
    this.removeClass(this.lookupSearch, 'hidden');
    modalBody.appendChild(this.lookupSearch);
    this.filterResults();
  };

  FieloLookupField.prototype.filterResults = function() {
    this.filter.Name =
      this.lookupSearchInput.value;
    this.pageNumber = 1;
    this.getValues(this.filterResultsCallback.bind(this));
  };

  FieloLookupField.prototype.filterResultsCallback = function(result) {
    while (this.optionsContainer.firstChild) {
      this.optionsContainer.removeChild(
        this.optionsContainer.firstChild);
    }
    this.options =
      result.Records; // eslint-disable-line no-undef
    var newOption;
    [].forEach.call(this.options, function(option) {
      newOption = this.createOption(option);
      newOption.setAttribute('data-record-id', option.Id);
      this.initOption(newOption);
      this.optionsContainer.appendChild(newOption);
    }, this);

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

  FieloLookupField.prototype.setLinksListeners_ = function() {
    this.links_.previous
      .addEventListener('click', this.getPreviousPage_.bind(this));

    this.links_.next
      .addEventListener('click', this.getNextPage_.bind(this));
  };

  FieloLookupField.prototype.getPreviousPage_ = function() {
    if (!this.links_.previous.classList.contains(this.CssClasses_.DISABLED)) {
      this.pageNumber--;
      this.getValues(this.filterResultsCallback.bind(this));
    }
  };

  FieloLookupField.prototype.getNextPage_ = function() {
    if (!this.links_.next.classList.contains(this.CssClasses_.DISABLED)) {
      this.pageNumber++;
      this.getValues(this.filterResultsCallback.bind(this));
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
      this.optionsContainer =
        this.lookupSearch.querySelector('.' + this.CssClasses_.CONTAINER);
      this.optionModel_ =
        this.element_.querySelector('.' + this.CssClasses_.MODEL);
      this.apiName =
        this.inputField.getAttribute(this.Constant_.FIELD);
      this.sObjectName =
        this.inputField.getAttribute(this.Constant_.OBJECT)
          .replace('[', '')
            .replace(']', '');
      this.fieldFullName =
        this.sObjectName + '.' + this.apiName;
      if (FrontEndJSSettings.LOOKUPS === null || // eslint-disable-line no-undef
      FrontEndJSSettings.LOOKUPS === undefined) { // eslint-disable-line no-undef
        FrontEndJSSettings.LOOKUPS = {}; // eslint-disable-line no-undef
      }
      if (FrontEndJSSettings.LOOKUPS[this.fieldFullName] === null || // eslint-disable-line no-undef
        FrontEndJSSettings.LOOKUPS[this.fieldFullName] === undefined) { // eslint-disable-line no-undef
        this.pageNumber = 1;
        this.recordsPerPage = 10;
        this.filter = {};
        this.getValues(this.getValuesCallback.bind(this)); // eslint-disable-line no-undef
      }
      this.inputField
        .addEventListener('focus', this.renderOptions.bind(this));
      this.inputField
        .addEventListener('keypress', this.preQuery.bind(this));
      this.lookupBtn =
        this.element_.querySelector('.' + this.CssClasses_.SEARCH_BUTTON);
      this.lookupBtn
        .addEventListener('click', this.showModal.bind(this));
      this.lookupSearchInput =
        this.lookupSearch
          .querySelector('.' + this.CssClasses_.SEARCH_FIELD_CONTAINER)
            .querySelector('[' + this.Constant_.FIELD + '="Name"]')
              .querySelector('input');
      this.lookupSearchBtn =
        this.lookupSearch
          .querySelector('.' + this.CssClasses_.SEARCH_RECORDS_BUTTON);
      this.lookupSearchBtn
        .addEventListener('click', this.filterResults.bind(this));

      // Paginator Buttons
      this.links_ = {
        previous:
          this.lookupSearch.querySelector('.' + this.CssClasses_.LINK_PREVIOUS),
        next:
          this.lookupSearch.querySelector('.' + this.CssClasses_.LINK_NEXT)
      };
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
