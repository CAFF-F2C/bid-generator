// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js or *_controller.ts.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Autosave from "stimulus-rails-autosave"
import PlacesAutocomplete from "stimulus-places-autocomplete"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.(js|ts)$/)
const contextComponents = require.context("../../components", true, /_controller\.js$/)
application.load(definitionsFromContext(context).concat(definitionsFromContext(contextComponents)))
application.register("autosave", Autosave)
application.register("places", PlacesAutocomplete)

// application.debug = true
// window.stimulusApplication = application
