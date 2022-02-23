import { Controller } from 'stimulus';

let index = 1;

export default class extends Controller {
  static targets = ['removeBtn', 'title'];

  connect() {
    console.log('Hello from questions_controller.js');
    this.removeBtnTarget.style.display = 'none';
    let questions = this.element.querySelectorAll('.questions > .question');
    let counter = 0;
    questions.forEach((question) => {
      if (counter !== 0) question.style.display = 'none';
      counter++;
    });
  }

  add(event) {
    event.preventDefault();
    console.log('Adding new question...');
    let questions = this.element.querySelectorAll('.questions > .question');
    if (index < questions.length) {
      questions[index].style.display = 'block';
      index += 1;
      this.removeBtnTarget.style.display = 'inline-block';
    }
    if (index == questions.length) {
      event.target.style.display = 'none';
    }
  }

  remove(event) {
    event.preventDefault();
    let questions = this.element.querySelectorAll('.questions > .question');
    let displayedQuestions = [];

    questions.forEach((q) => {
      if (q.style.display != 'none') displayedQuestions.push(q);
    });

    if (displayedQuestions.length > 0) {
      displayedQuestions[displayedQuestions.length - 1].style.display = 'none';
      index -= 1;
    }

    if (displayedQuestions.length == 2) {
      this.removeBtnTarget.style.display = 'none';
    }
  }
}
