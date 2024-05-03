# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "markdown_converter", preload: false
pin "preview", preload: false
pin "showdown" # @2.1.0
pin "highlight.js", to: "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/es/highlight.min.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
