import { Application } from "stimulus"
import RfpScoresController from "../../../app/components/buyers/rfp_scores_component/rfp_scores_controller.js"

describe('RfpScoresController', () => {
  let application, controller, root, scoreHtml

  beforeEach((done) => {
    root = document.createElement("div")
    document.body.appendChild(root)
    scoreHtml = `
      <div id='score_category_3' data-action="click->rfp-scores#click" data-category-id='3'>
        <div class='rfp-scores__description hidden'></div>
      </div>
    `
    root.innerHTML = `
      <div id='scores' data-controller="rfp-scores">
        ${scoreHtml}
      </div>
    `

    application = Application.start()
    application.register("rfp-scores", RfpScoresController)

    setImmediate(() => {
      controller = application.controllers[0]
      done()
    })
  })

  afterEach(() => {
    application.stop()
    document.body.removeChild(root)
  })

  describe('#onClick', () => {
    beforeEach(() => {
      root.querySelector('#score_category_3').click()
    })

    it('shows the description', () => {
      expect(root.querySelector('.rfp-scores__description').classList).not.toContain('hidden')
    })

    describe('when it is clicked again', () => {
      beforeEach(() => {
        root.querySelector('#score_category_3').click()
      })

      it('hides the description', () => {
        expect(root.querySelector('.rfp-scores__description').classList).toContain('hidden')
      })
    })

    describe('when the contents have been replaced', () => {
      beforeEach((done) => {
        const scoreNode = document.createElement('template')
        scoreNode.innerHTML = scoreHtml
        root.querySelector('#scores').replaceChildren(scoreNode.content)
        setImmediate(done)
      })

      it('shows the description', () => {
        expect(root.querySelector('.rfp-scores__description').classList).not.toContain('hidden')
      })
    })
  })
})
