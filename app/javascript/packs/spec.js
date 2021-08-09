const specContext = require.context("../../../spec/javascripts", true, /_spec\.js$/)
specContext.keys().forEach(specContext)
