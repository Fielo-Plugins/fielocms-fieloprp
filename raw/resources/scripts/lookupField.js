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
    GET_METHOD: 'LookupFieldController.getValues'

  };
  /**
   * Css name classes
   *
   * @enum {string}
   * @private
   */
  FieloLookupField.prototype.CssClasses_ = {
    FIELD: 'cms-prp-lookup__field',
    SELECT: 'cms-prp-lookup__select',
    OPTION: 'cms-prp-lookup__option'
  };

  FieloLookupField.prototype.getValues = function() {
    Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
      this.Constant_.GET_METHOD,
      this.sObjectName,
      this.getValuesCallback.bind(this),
      {
        escape: false
      }
    );
  };

  FieloLookupField.prototype.getValuesCallback = function(result) {
    var options = {};
    console.log(result);
    if (result) {
      [].forEach.call(result, function(option) {
        options[option.Id] = option.Name;
      }, this);
    }
    console.log(this.fieldFullName);
    FrontEndJSSettings.LOOKUPS[this.fieldFullName] = // eslint-disable-line no-undef
      options;
  };

  FieloLookupField.prototype.renderOptions = function() {
    if (!this.isLoaded) {
      while (this.selectOptions.firstChild) {
        this.selectOptions.removeChild(
          this.selectOptions.firstChild);
      }
      this.options =
        FrontEndJSSettings.LOOKUPS[this.fieldFullName]; // eslint-disable-line no-undef
      var newOption;
      var index = 0;
      [].forEach.call(Object.keys(this.options), function(option) {
        newOption = this.createOption();
        newOption.value = this.options[option];
        newOption.label = option;
        newOption.innerHTML = option;
        newOption.setAttribute('data-record-id', option);
        this.selectOptions.add(newOption, index++);
      }, this);
      this.isLoaded = true;
    }
  };

  FieloLookupField.prototype.getLookupId = function(event) {
    if (event.srcElement) {
      var options = this.selectOptions
        .querySelectorAll('option');
      [].forEach.call(options, function(option) {
        if (option.value === event.srcElement.value) {
          this.inputField.setAttribute('data-lookup-id',
            option.getAttribute('data-record-id'));
        }
      }, this);
    }
  };

  FieloLookupField.prototype.createOption = function() {
    var option = document.createElement('option');
    this.addClass(option, this.CssClasses_.OPTION);
    return option;
  };

  FieloLookupField.prototype.addClass = function(element, className) {
    var classString = element.className;
    var newClass = classString.concat(' ' + className);
    element.className = newClass;
  };

  /**
   * Inicializa el elemento
   */
  FieloLookupField.prototype.init = function() {
    if (this.element_) {
      this.inputField =
        this.element_.querySelector('.' + this.CssClasses_.FIELD);
      this.selectOptions =
        this.element_.querySelector('.' + this.CssClasses_.SELECT);
      this.apiName =
        this.inputField.getAttribute('data-field-name');
      this.sObjectName =
        this.inputField.getAttribute('data-object-name')
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
        console.log('getValues');
        this.getValues(); // eslint-disable-line no-undef
      }
      this.inputField
        .addEventListener('focus', this.renderOptions.bind(this));
      this.inputField
        .addEventListener('change', this.getLookupId.bind(this));
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
