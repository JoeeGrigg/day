import { Controller } from 'stimulus';
import flatpickr from 'flatpickr';
import { debounce } from 'ts-debounce';

export default class extends Controller {
  initialize() {
    this.setupDatePicker();
    this.addTrixListener();
    this.save = debounce(this.saveHandler, 1000);
  }

  setupDatePicker() {
    flatpickr('.datetime', {
      enableTime: true,
      dateFormat: 'Y-m-d H:i:S', // THIS HAS SOME PROBLEMS (Time not being saved)
      altFormat: 'l, j F Y @ G:i K',
      altInput: true,
      position: 'auto'
    });
  }

  addTrixListener() {
    let pageEditor = document.querySelector('#page-trix-editor');
    if (pageEditor) {
      pageEditor.addEventListener('trix-change', () => {
        this.handleChange();
      })
    }
  }

  saveHandler() {
    console.log('Saving', new Date().getTime());
  }

  handleChange() {
    this.save();
  }
}
