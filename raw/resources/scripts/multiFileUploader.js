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
    UPLOAD_CONTROLLER: 'FieloCMSPRP_FormInvoiceCtrl.saveTheChunk',
    DELETE_FILES_CONTROLLER: 'FieloCMSPRP_FormInvoiceCtrl.deleteAttachments'
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
    DELETE: 'cms-prp-button__remove',
    FORM_INVOICE: 'cms-prp-invoice-form'

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
    var fileIndex = attachmentItem.getAttribute('data-record-id');
    if (this.fileList) {
      if (this.fileList[fileIndex]) {
        delete this.fileList[fileIndex];
      }
    }
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
    if (file.Id) {
      this.currentAttachmentRecord
        .setAttribute('data-record-id',
          file.Id);
    } else {
      this.currentAttachmentRecord
        .setAttribute('data-record-id',
          Object.keys(this.fileList).length - 1);
    }
    this.currentAttachmentRecord
      .setAttribute('data-has-attachment', 'true');
    try {
      this.currentAttachmentRecord
      .style.setAttribute('display', '');
    } catch (e) {
      try {
        this.currentAttachmentRecord
          .style.display = null;
      } catch (e) {
        console.log(e);
      }
    }
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
          var message = FrontEndJSSettings.LABELS.MaxFileSize.replace('{0}', // eslint-disable-line no-undef
            (this.Constant_.MAX_FILE_SIZE / 1024 / 1024).toFixed(2).toString());
          this.throwMessage(message);
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
        if (file instanceof Blob) {
          if (file) {
            var fr = new FileReader();
            fr.onloadend = function(e) {
              var data;
              if (e) {
                data = e.target.result;
              } else {
                data = fr.content;
              }
              if (data) {
                attachmentObject.Body = window.btoa(data);
                attachmentObject.Name = file.name;
              } else {
                console.log('Error loading the file content.');
              }
            };
            fr.readAsBinaryString(file);
          }
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
      if (file) {
        if (file instanceof Blob) {
          var fr = new FileReader();
          fr.onload = function(e) {
            var data;
            if (e) {
              data = e.target.result;
            } else {
              data = fr.content;
            }
            if (data) {
              var fileContents = window.btoa(data);
              self.upload(parentId, file, fileContents);
            } else {
              console.log('Error loading the file content.');
            }
          };
          fr.readAsBinaryString(file);
        }
      } else {
        this.throwMessage('You must choose a file before trying to upload it');
      }
    } else {
      this.changeInvoiceStatus();
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
                .changeInvoiceStatus.call(self);
            }
          } else {
            FieloMultiFileUploaderPRP.prototype
              .changeInvoiceStatus.call(self);
          }
        },
        {escape: true}
      );
  };

  FieloMultiFileUploaderPRP.prototype.changeInvoiceStatus = function() {
    this.formInvoice_ = document
      .querySelector('.' + this.CssClasses_.FORM_INVOICE)
      .FieloFormInvoice;
    if (this.formInvoice_) {
      this.formInvoice_.changeStatus();
    }
  };

  FieloMultiFileUploaderPRP.prototype.throwMessage = function(message) { // eslint-disable-line max-len
    fieloUtils.message.FieloMessage.clear(); // eslint-disable-line no-undef
    fieloUtils.message.FieloMessage.addMessages( // eslint-disable-line no-undef
    fieloUtils.site.FieloSite.getLabel( // eslint-disable-line no-undef
      message)
    );
    fieloUtils.message.FieloMessage.show(); // eslint-disable-line no-undef
  };

  componentHandler.register({ // eslint-disable-line no-undef
    constructor: FieloMultiFileUploaderPRP,
    classAsString: 'FieloMultiFileUploaderPRP',
    cssClass: 'cms-prp-multifileuploader',
    widget: true
  });
})();
