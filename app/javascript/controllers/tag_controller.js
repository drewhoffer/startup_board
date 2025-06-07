import { Controller } from "@hotwired/stimulus"
import Tagify from '@yaireo/tagify'

const COLORS = [
  "#2196F3",
  "#FF3D00",
  "#00E676",
  "#FFEB3B",
  "#6200EA"
]

export default class extends Controller {
  connect() {
    this.tagify = new Tagify(this.element, {
      templates: {
        tag: (tagData) => {
          // Pick a random color for each tag
          const color = COLORS[Math.floor(Math.random() * COLORS.length)]
          return `<tag title='${tagData.value}'
                       contenteditable='false'
                       spellcheck='false'
                       class='tagify__tag'
                       style='--tag-bg:${color};'>
                    <x title='remove tag' class='tagify__tag__removeBtn'></x>
                    <div>
                      <span class='tagify__tag-text'>${tagData.value}</span>
                    </div>
                  </tag>`
        }
      }
    })
    this.form = this.element.closest('form')
    if (this.form) {
      this.form.addEventListener('submit', this.handleSubmit?.bind(this))
    }
  }

  preventEnter(event) {
    if (event.key === "Enter") {
      event.preventDefault();
    }
  }

  handleSubmit(event) {
    // Convert Tagify value to comma-separated string for Rails
    if (this.tagify) {
      const tags = this.tagify.value.map(tag => tag.value).join(',')
      this.element.value = tags
    }
  }
}
