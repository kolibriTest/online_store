# config/importmap.rb
pin "application"
pin "@hotwired/turbo-rails", to: "https://cdn.skypack.dev/@hotwired/turbo-rails"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
