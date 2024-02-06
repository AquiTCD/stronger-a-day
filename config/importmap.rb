# Pin npm packages by running ./bin/importmap
pin "application"

# Necessary for Hotwire. If there are no pins, it will be an error 'Uncaught TypeError: Failed to resolve module specifier "@hotwired/turbo-rails".'
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.turbo.min.js"
pin "tailwindcss-stimulus-components" # @4.0.4
pin "driver.js" # @1.3.1

pin_all_from "app/javascript/controllers", under: "controllers"
