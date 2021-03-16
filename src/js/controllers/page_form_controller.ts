import { Controller } from 'stimulus';
import { debounce } from 'ts-debounce';
import flatpickr from 'flatpickr';
import Axios from 'axios'
import Notyf from '../notyf';

export default class extends Controller {
  private save = debounce(this.handleSave, 1000);
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
      dateFormat: 'Y-m-d H:i:S', // THIS HAS SOME PROBLEMS (Time not being saved)
      altFormat: 'l, j F Y @ G:i K',
      altInput: true,
      position: 'auto'
    });
  }

  addTrixListeners(): void {
    let pageEditor = document.querySelector('#page-trix-editor');
    if (pageEditor == null) return;
    pageEditor.addEventListener('trix-change', () => {
      this.handleChange();
    });
    pageEditor.addEventListener('trix-attachment-add', (e) => {
      console.log(e.attachment); // ATTACHMENT DOES EXIST BUT IS NOT RECOGNISED
    });
  }

  handleSave(): void {
    let params = new URLSearchParams(document.location.search.substring(1));
    let formData = new FormData(this.formTarget);
    Axios({
      method: 'post',
      url: `/pages/${params.get('p')}`,
      data: formData,
      headers: { 'Content-Type': 'multipart/form-data' }
    })
    .then(res => {
      Notyf.success('Saved!');
    })
    .catch(err => {
      Notyf.success('Failed to save...');
    })
    
  }

  handleChange(): void {
    this.save();
  }
}
