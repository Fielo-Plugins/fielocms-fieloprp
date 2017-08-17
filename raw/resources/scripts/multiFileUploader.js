(function() {
  'use strict';

  /**
   * @description FieloMultiFileUploaderPRP controller.
   * Enables multi file upload
   * Implements the design patterns defined by MDL in
   * {@link https://github.com/jasonmayes/mdl-component-design-pattern}
   *
   * @version 1
   * @author Tiago Bittencourt Leal <tiago.leal@fielo.com>
   * @param {HTMLElement} element - extended element.
   * @constructor
   */
  var FieloMultiFileUploaderPRP = function FieloMultiFileUploaderPRP(element) {
    this.element_ = element;

    // Initialize instance.
    this.init();
  };
  window.FieloMultiFileUploaderPRP = FieloMultiFileUploaderPRP;

  /**
   * Guarda las constantes en un lugar para que sean facilmente actualizadas
   * @enum {string | number}
   * @private
   */
  FieloMultiFileUploaderPRP.prototype.Constant_ = {
    MAX_FILE_SIZE: 4350000,
    CHUNK_SIZE: 950000,
    UPLOAD_CONTROLLER: 'FormInvoiceAPI.saveTheChunk',
    DELETE_FILES_CONTROLLER: 'FormInvoiceAPI.deleteAttachments'
  };

  /**
   * Guarda strings para nombres de clases definidas por este componente que
   * son usadas por JavaScript.
   * Esto nos permite cambiarlos solo en un lugar
   * @enum {string}
   * @private
   */
  FieloMultiFileUploaderPRP.prototype.CssClasses_ = {
    PAGINATOR: 'fielosf-paginator',
    CONTAINER: 'cms-prp-attachemnts',
    ATTACHMENT_RECORD: 'cms-prp-attachment-record',
    NEW: 'fielo-button__new-attachment',
    DELETE: 'cms-prp-button__remove'

  };

  /**
   * Inicializa el elemento
   */
  FieloMultiFileUploaderPRP.prototype.init = function() {
    if (this.element_) {
      this.element_
        .querySelector('#file-upload-input')
          .addEventListener(
            'change', this.handleFile.bind(this));
      this.container_ =
        this.element_.getElementsByClassName(this.CssClasses_.CONTAINER)[0];
      this.attachmentItems_ =
        this.element_
          .querySelectorAll('.' + this.CssClasses_.ATTACHMENT_RECORD);
      this.model_ =
        this.attachmentItems_[0].cloneNode(true);
      this.newBtn_ =
        document.getElementsByClassName(this.CssClasses_.NEW)[0];

      if (this.newBtn_) {
        this.newBtn_
          .addEventListener('click', this.newAttachment.bind(this));
      }
      [].forEach.call(this.attachmentItems_, this.initItem_.bind(this));
    }
  };

  FieloMultiFileUploaderPRP.prototype.initItem_ = function(attachmentItem) {
    attachmentItem.deleteBtn_ =
      attachmentItem.getElementsByClassName(this.CssClasses_.DELETE)[0];
    attachmentItem.deleteBtn_.addEventListener(
      'click',
      this.deleteItem_.bind(this, attachmentItem)
    );
  };

  FieloMultiFileUploaderPRP.prototype.deleteItem_ = function(attachmentItem) {
    attachmentItem.parentNode.removeChild(attachmentItem);
    this.attachmentItems_ =
      this.element_.querySelectorAll('.' + this.CssClasses_.ITEM_RECORD);
  };

  FieloMultiFileUploaderPRP.prototype.newAttachment = function() {
    this.element_.querySelector('#file-upload-input').click();
  };

  FieloMultiFileUploaderPRP.prototype.deleteFilesFromServer = function() {
    if (this.deleteList) {
      if (this.deleteList.length > 0) {
        var self = this;
        var filesToDelete = this.deleteList.slice();
        this.deleteList = null;
        Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
          this.Constant_.DELETE_FILES_CONTROLLER,
          filesToDelete,
          this.uploadFile.bind(this, self.parentId),
          {escape: true}
        );
      }
    }
  };

  /*
  FieloMultiFileUploaderPRP.prototype.addEmptyFilePill = function(fakeFile) {
    this.currentPillContainer = this.filePills_[0].cloneNode(true);
    this.cardBody_ = this.element_.getElementsByClassName(
      this.CssClasses_.CARD_BODY)[0];
    this.cardBody_.appendChild(this.currentPillContainer);
    $(this.currentPillContainer).removeClass('slds-hidden');
    $(this.currentPillContainer).removeClass('slds-is-collapsed');
    $(this.currentPillContainer).removeClass('slds-pill__model');
    this.currentPillLabel =
      this.currentPillContainer.getElementsByClassName(
        this.CssClasses_.PILL_LABEL)[0];
    this.currentPillLabel.innerHTML = fakeFile.Name;
    this.currentPillLabel.setAttribute('title', fakeFile.Name);
    this.currentPillLabel.setAttribute('data-record-id',
      fakeFile.Id);
    this.initPill(this.currentPillContainer);
  };
  */

  FieloMultiFileUploaderPRP.prototype.addFileRecord = function(file) {
    this.currentAttachmentRecord =
      this.attachmentItems_[this.attachmentItems_.length - 1];
    if (this.currentAttachmentRecord) {
      if (this.currentAttachmentRecord
        .getAttribute('data-has-attachment') === 'true') {
        this.currentAttachmentRecord = this.model_.cloneNode(true);
        this.container_.appendChild(this.currentAttachmentRecord);
        this.initItem_(this.currentAttachmentRecord);
      }
    } else {
      this.currentAttachmentRecord = this.model_.cloneNode(true);
      this.container_.appendChild(this.currentAttachmentRecord);
      this.initItem_(this.currentAttachmentRecord);
    }
    this.currentAttachmentRecord
      .querySelector('span')
        .innerHTML = file.name;
    this.currentAttachmentRecord
      .setAttribute('data-record-id',
        Object.keys(this.fileList).length - 1);
    this.currentAttachmentRecord
      .setAttribute('data-has-attachment', 'true');
    this.currentAttachmentRecord
      .style.display = null;
  };

  FieloMultiFileUploaderPRP.prototype.handleFile = function(event) {
    this.input_ = event.target;
    if (this.fileList === null || this.fileList === undefined) {
      this.fileList = {};
    }
    [].forEach.call(this.input_.files, function(file) {
      try {
        if (file.size < this.Constant_.MAX_FILE_SIZE) {
          this.fileList[Object.keys(this.fileList).length.toString()] = file;
          this.addFileRecord(file);
        } else {
          var message = 'File size cannot exceed ' +
            (this.Constant_.MAX_FILE_SIZE / 1024 / 1024).toFixed(2) +
            ' Mbytes.';
          this.throwMessage(message, 'error');
          this.input_.value = null;
        }
      } catch (e) {
        console.log('error' + e);
      }
    },
      this
    );
    this.input_.value = null;
  };

  window.FieloMultiFileUploaderPRP_handleFile = // eslint-disable-line camelcase
    FieloMultiFileUploaderPRP.prototype.handleFile; // eslint-disable-line camelcase

  FieloMultiFileUploaderPRP.prototype.get = function() {
    var attachments = [];
    var attachmentObject = {};
    var file;
    if (this.fileList) {
      [].forEach.call(Object.keys(this.fileList), function(fileIndex) {
        file = this.fileList[fileIndex];
        if (file) {
          var fr = new FileReader();
          fr.onloadend = function() {
            attachmentObject.Body = window.btoa(fr.result);
            attachmentObject.Name = file.name;
          };
          fr.readAsBinaryString(file);
        }
        attachments.push(attachmentObject);
      },
        this
      );
    }
    return attachments;
  };

  FieloMultiFileUploaderPRP.prototype.uploadFile = function(parentId) {
    this.parentId = parentId;
    if (this.deleteList) {
      this.deleteFilesFromServer();
    } else if (this.fileList) {
      var filePtr = Object.keys(this.fileList)[0];
      var file = this.fileList[filePtr];
      delete this.fileList[filePtr];
      var self = this;
      console.log(file);
      if (file) {
        var fr = new FileReader();
        fr.onloadend = function() {
          var fileContents = window.btoa(fr.result);
          self.upload(parentId, file, fileContents);
        };
        fr.readAsBinaryString(file);
      } else {
        this.throwMessage('You must choose a file before trying to upload it',
          'error');
      }
    } else {
      this.redirectToParent(parentId);
    }
  };

  FieloMultiFileUploaderPRP.prototype.upload = function(parentId, file, fileContents) { // eslint-disable-line max-len
    var fromPos = 0;
    var toPos = Math.min(fileContents.length,
      fromPos + this.Constant_.CHUNK_SIZE);

    // start with the initial chunk
    this.uploadChunk(parentId, file, fileContents, fromPos, toPos, '');
  };

  FieloMultiFileUploaderPRP.prototype.uploadChunk = function(
    parentId, file, fileContents, fromPos, toPos, attachId) {
    var chunk = fileContents.substring(fromPos, toPos);
    var self = this;
    Visualforce.remoting.Manager.invokeAction( // eslint-disable-line no-undef
        this.Constant_.UPLOAD_CONTROLLER,
        parentId,
        file.name,
        encodeURIComponent(chunk),
        file.type,
        attachId,
        function(a) {
          attachId = a;
          fromPos = toPos;
          toPos = Math.min(fileContents.length, fromPos +
            self.Constant_.CHUNK_SIZE);
          if (fromPos < toPos) {
            self.uploadChunk(
              parentId, file, fileContents, fromPos, toPos, attachId);
          } else if (self.fileList) {
            if (Object.keys(self.fileList).length > 0) {
              self.uploadFile(parentId);
            } else {
              FieloMultiFileUploaderPRP.prototype
                .redirectToParent.call(self, parentId);
            }
          } else {
            FieloMultiFileUploaderPRP.prototype
              .redirectToParent.call(self, parentId);
          }
        },
        {escape: true}
      );
  };

  FieloMultiFileUploaderPRP.prototype.redirectToParent = function(parentId) {
    fieloUtils.spinner.FieloSpinner.show(); // eslint-disable-line no-undef
    var result = {message: 'The invoice was saved successfully',
      redirectURL: '/' + parentId};
    this.throwMessage(result.message, 'success');
    if (window.redirectURL) {
      result.redirectURL = window.redirectURL;
    }
    location.replace(result.redirectURL);
  };

  FieloMultiFileUploaderPRP.prototype.throwMessage = function(message, redirect, time) { // eslint-disable-line max-len
    fieloUtils.message.FieloMessage.clear(); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.addMessages( // eslint-disable-line no-undef
    fieloUtils.site.FieloSite.getLabel( // eslint-disable-line no-undef
      message)
    );
    fieloUtils.message.FieloMessage.setRedirect(redirect, time); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.show(); // eslint-disable-line no-undef
  };

  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloMultiFileUploaderPRP,
    classAsString: 'FieloMultiFileUploaderPRP',
    cssClass: 'cms-prp-multifileuploader',
    widget: true
  });
})();
