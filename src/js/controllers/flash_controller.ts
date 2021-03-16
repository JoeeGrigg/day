import { Controller } from 'stimulus';
import Notyf from '../notyf';

interface Message {
  type: string,
  value: string
}

export default class extends Controller {
  private messages: Array<Message> = [];
  private typePrefix = 'flash-type-';

  initialize(): void {
    const messageNodes = document.querySelectorAll('.flash-messages .flash-message');
    messageNodes.forEach(node => {
      let typeClasses = Array.from(node.classList).filter(c => c.startsWith(this.typePrefix));
      let type = typeClasses.length > 0 ? typeClasses[0].slice(this.typePrefix.length) : 'general'
      this.messages.push({
        type: type,
        value: node.innerHTML
      });
    })
  }

  connect() {
    this.messages.forEach(message => {
      switch (message.type) {
        case 'success': {
          Notyf.success(message.value);
          break;
        };
        case 'failure': {
          Notyf.error(message.value);
          break;
        };
        default: {
          Notyf.open({type: 'info', message: message.value});
          break;
        }
      }
    })
  }
}