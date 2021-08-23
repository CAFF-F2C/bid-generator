// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js or *_controller.ts.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.(js|ts)$/)
const contextComponents = require.context("../../components", true, /_controller\.js$/)
application.load(definitionsFromContext(context).concat(definitionsFromContext(contextComponents)))
application.debug = true
window.stimulusApplication = application
