// Entry point for the build script in your package.json
import Rails from "@rails/ujs"

import * as ActiveStorage from "@rails/activestorage"
import "./channels"
import "./controllers"

Rails.start()
ActiveStorage.start()

function importAll(r) {
  r.keys().forEach(r)
}

importAll(require.context("../components", true, /[_\/]component\.js$/))
// importAll(require.context("../components", true, /[_\/]component\.css$/))
