import { Controller } from 'stimulus';
import { debounce } from 'ts-debounce';
import flatpickr from 'flatpickr';
import Axios from 'axios';
import Notyf from '../notyf';

interface IUploadResponse {
  id: string
}

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
      dateFormat: 'Z',
      altInput: true,
      altFormat: 'l, j F Y @ G:i K',
      position: 'auto'
    });
  }

  addTrixListeners(): void {
    let pageEditor = document.querySelector('#page-trix-editor');
    if (pageEditor == null) return;
    pageEditor.addEventListener('trix-change', () => { this.handleChange() });
    pageEditor.addEventListener('trix-attachment-add', (e: any) => { this.handleAttachment(e) });
    pageEditor.addEventListener('trix-attachment-remove', (e: any) => { this.removeAttachment(e) });
  }

  handleSave(): void {
    let formData = new FormData(this.formTarget);
    Axios({
      method: 'post',
      url: `/pages/${this.params.get('p')}`,
      data: formData,
      headers: { 'Content-Type': 'multipart/form-data' }
    })
    .then(_res => { Notyf.success('Saved!') })
    .catch(_err => { Notyf.success('Failed to save...') })
  }

  handleChange(): void {
    this.save();
  }

  async handleAttachment(e: any) { // TODO: EVENT NEEDS TO BE MADE THE CORRECT TYPE
    if (e.attachment.file) {
      let res = await this.uploadAttachment(e.attachment.file);
      let page_id = this.params.get('p')
      e.attachment.setAttributes({
        url: `/attachments/${page_id}/${res.data.id}`,
        href: `/attachments/${page_id}/${res.data.id}?content-disposition=attachment`,
        uuid: res.data.id
      })
    } else if (e.attachment.attachment.attributes.values.uuid) {
      await this.restoreAttachment(e.attachment.attachment.attributes.values.uuid);
    }
  }

  async uploadAttachment(file: any) {
    let formData = new FormData();
    formData.set('attachment:file', file);
    return await Axios.request<IUploadResponse>({
      method: 'post',
      url: `/attachments/${this.params.get('p')}`,
      data: formData,
      headers: { 'Content-Type': 'multipart/form-data' }
    });
  }

  async removeAttachment(e: any) {
    let uuid = e.attachment.attachment.attributes.values.uuid;
    if (uuid === undefined) return;
    await Axios.request({
      method: 'delete',
      url: `/attachments/${this.params.get('p')}/${uuid}`
    });
  }

  async restoreAttachment(uuid: string) {
    await Axios.request({
      method: 'put',
      url: `/attachments/${this.params.get('p')}/${uuid}`
    });
  }
}
