import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  expandedDescriptions = []

  connect() {
    this.observer = new MutationObserver(this.showDescriptions.bind(this));
    this.observer.observe(this.element, {childList: true});
  }

  click(event) {
    this.toggleDescription(event.currentTarget.dataset.categoryId)
  }

  showDescriptions() {
    this.expandedDescriptions.forEach(categoryId => {
      document.querySelector(`#score_category_${categoryId} .rfp-scores__description`).classList.remove("hidden")
    })
  }

  toggleDescription (categoryId) {
    const result = this.expandedDescriptions.filter(id => id != categoryId)
    if (result.length < this.expandedDescriptions.length) {
      this.expandedDescriptions = result
    } else {
      this.expandedDescriptions.push(categoryId)
    }

    event.currentTarget.querySelector('.rfp-scores__description').classList.toggle("hidden")
  }
}
