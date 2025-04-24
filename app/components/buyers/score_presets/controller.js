import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {}

  click(event) {
    this.toggleDescription(event.currentTarget.dataset.categoryId)
  }

  toggleDescription (categoryId) {
    event.currentTarget.querySelector('.category-description').classList.toggle("hidden")
    event.currentTarget.querySelector('.category-description').classList.toggle("sm:line-clamp-1")
    event.currentTarget.querySelector('.category-description-more').classList.toggle("hidden")
  }
}
