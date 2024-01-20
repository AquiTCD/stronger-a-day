# Pin npm packages by running ./bin/importmap
pin "application"

# Necessary for Hotwire. If there are no pins, it will be an error 'Uncaught TypeError: Failed to resolve module specifier "@hotwired/turbo-rails".'
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
