// app/javascript/controllers/dropzone_controller.js
import Dropzone from "dropzone";
import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";
import {
  getMetaValue,
  toArray,
  findElement,
  removeElement,
  insertAfter
} from "../helpers";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    console.log('connected to dropzone')
    this.dropZone = createDropZone(this);
    this.loadExistingFiles();
    this.hideFileInput();
    this.bindEvents();
    Dropzone.autoDiscover = false; // necessary quirk for Dropzone error in console
  }

  loadExistingFiles() {
    this.existingFiles.forEach(file => {
      this.dropZone.emit("addedfile", file);
      this.dropZone.emit("thumbnail", file, file.url);
      this.dropZone.emit("complete", file);
      this.dropZone.files.push(file)
    })
  }

  // Private
  hideFileInput() {
    this.inputTarget.disabled = true;
    this.inputTarget.style.display = "none";
  }

  bindEvents() {
    this.dropZone.on("addedfile", file => {
      setTimeout(() => {
        console.log('files', this.dropZone.files)
        if (this.dropZone.options.maxFiles == 2 && this.dropZone.files.length > 1) {
          var existingFile = this.dropZone.files.shift()
          this.dropZone.removeFile(existingFile)
          if (existingFile.existing) this.deleteFileFromServer(existingFile)
        }
        file.accepted && createDirectUploadController(this, file).start();
        // if (this.dropZone.options.maxFiles == 1) this.dropZone.disable()
      }, 500);
    });

    this.dropZone.on("removedfile", file => {
      if (file.existing) {
        this.deleteFileFromServer(file)
      }
      file.controller && removeElement(file.controller.hiddenInput);
      // this.dropZone.enable()
    });

    this.dropZone.on("canceled", file => {
      file.controller && file.controller.xhr.abort();
    });
  }

  deleteFileFromServer(file) {
    var fileInput = document.getElementById('destroy-file')
    console.log("file", file)
    console.log("fileInput", fileInput)
    fileInput.value = file.id
    fileInput.parentNode.submit()
  }

  get headers() {
    return { "X-CSRF-Token": getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url");
  }

  get maxFiles() {
    return this.data.get("maxFiles") || 1;
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 256;
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles");
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }

  get width() {
    return this.data.get("width") || true;
  }

  get height() {
    return this.data.get("height") || true;
  }

  get existingFiles() {
    return this.data.get("existingFiles") ? JSON.parse(this.data.get("existingFiles")) : [];
  }
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = createDirectUpload(file, source.url, this);
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;
    this.hiddenInput = this.createHiddenInput();
    this.directUpload.create((error, attributes) => {
      if (error) {
        removeElement(this.hiddenInput);
        this.emitDropzoneError(error);
      } else {
        this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess();
      }
    });
  }

  createHiddenInput() {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = this.source.inputTarget.name;
    insertAfter(input, this.source.inputTarget);
    return input;
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr);
    this.emitDropzoneUploading();
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener("progress", event =>
      this.uploadRequestDidProgress(event)
    );
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    findElement(
      this.file.previewTemplate,
      ".dz-upload"
    ).style.width = `${progress}%`;
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit("processing", this.file);
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit("error", this.file, error);
    this.source.dropZone.emit("complete", this.file);
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit("success", this.file);
    this.source.dropZone.emit("complete", this.file);
  }
}

function createDirectUploadController(source, file) {
  return new DirectUploadController(source, file);
}

function createDirectUpload(file, url, controller) {
  return new DirectUpload(file, url, controller);
}

function createDropZone(controller) {
  return new Dropzone(controller.element, {
    url: controller.url,
    headers: controller.headers,
    maxFiles: controller.maxFiles,
    maxFilesize: controller.maxFileSize,
    acceptedFiles: controller.acceptedFiles,
    addRemoveLinks: controller.addRemoveLinks,
    autoQueue: false,
    thumbnailWidth: controller.width,
    thumbnailHeight: controller.height
  });
}
