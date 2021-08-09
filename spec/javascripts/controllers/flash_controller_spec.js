import { Application } from "stimulus"
import FlashController from "../../../app/javascript/controllers/flash_controller.js"

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
    jasmine.clock().install()

    setImmediate(() => {
      controller = application.controllers[0]
      done()
    })
  })

  afterEach(() => {
    application.stop()
    document.body.removeChild(root)
    jasmine.clock().uninstall()
  })

  describe('#onClick', () => {
    beforeEach(() => {
      root.querySelector('button').click()
    })

    it('hides the element', () => {
      expect(root.querySelector('section').classList).toContain('hidden')
    })

    describe('when five seconds pass', () => {
      beforeEach(() => {
        jasmine.clock().tick(5001)
      })

      it('removes the element', () => {
        expect(root.querySelector('section')).toBeNull()
      })
    })
  })
})
