import { Controller } from 'stimulus';
import { debounce } from 'ts-debounce';
import flatpickr from 'flatpickr';
import Axios from 'axios'
import Notyf from '../notyf';

export default class extends Controller {
  private save = debounce(this.handleSave, 1000);
  private params = new URLSearchParams(document.location.search.substring(1));
  declare readonly formTarget: HTMLFormElement;

  static get targets(): Array<string> {
    return [ "form" ];
  }

  initialize(): void {
    this.setupDatePicker();
    this.addTrixListeners();
  }

  setupDatePicker(): void {
    flatpickr('.datetime', {
      enableTime: true,
      dateFormat: 'Y-m-d H:i:S', // TODO: THIS HAS SOME PROBLEMS (Time not being saved)
      altFormat: 'l, j F Y @ G:i K',
      altInput: true,
      position: 'auto'
    });
  }

  addTrixListeners(): void {
    let pageEditor = document.querySelector('#page-trix-editor');
    if (pageEditor == null) return;
    pageEditor.addEventListener('trix-change', () => { this.handleChange() });
    pageEditor.addEventListener('trix-attachment-add', (e: any) => { this.handleAttachment(e) });
  }

  handleSave(): void {
    let formData = new FormData(this.formTarget);
    Axios({
      method: 'post',
      url: `/pages/${this.params.get('p')}`,
      data: formData,
      headers: { 'Content-Type': 'multipart/form-data' }
    })
    .then(_res => {
      Notyf.success('Saved!');
    })
    .catch(_err => {
      Notyf.success('Failed to save...');
    })
  }

  handleChange(): void {
    this.save();
  }

  handleAttachment(e: any): void { // TODO: EVENT NEEDS TO BE MADE THE CORRECT TYPE
    if (e.attachment.file) this.uploadAttachment(e.attachment.file);
  }

  uploadAttachment(file: any) {
    let formData = new FormData();
    formData.set('attachment:file', file);
    Axios({
      method: 'post',
      url: `/attachments/${this.params.get('p')}`,
      data: formData,
      headers: { 'Content-Type': 'multipart/form-data' }
    })
    .then(res => {
      console.log('Res: ', res);
    })
    .catch(err => {
      console.log('Err: ', err);
    })
  }
}
