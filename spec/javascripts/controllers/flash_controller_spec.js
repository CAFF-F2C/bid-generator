import { Application } from "stimulus"
import FlashController from "../../../app/components/flash_component/flash_controller.js"

describe('FlashController', () => {
  let application, controller, root

  beforeEach((done) => {
    root = document.createElement("div")
    document.body.appendChild(root)
    root.innerHTML = `
      <section data-controller="flash">
        <button data-action="click->flash#close">x</button>
      </section>`

    application = Application.start()
    application.register("flash", FlashController)

    setTimeout(() => {
      controller = application.controllers[0]
      done()
    }, 0)
  })

  afterEach(() => {
    application.stop()
    document.body.removeChild(root)
  })

  describe('#onClick', () => {
    beforeEach(() => {
      root.querySelector('button').click()
    })

    it('hides the element', () => {
      expect(root.querySelector('section').classList).toContain('hidden')
    })

    describe('when five seconds pass', () => {
      beforeEach((done) => {
        setTimeout(done, 5001)
      }, 6000)

      it('removes the element', () => {
        expect(root.querySelector('section')).toBeNull()
      })
    })
  })
})
