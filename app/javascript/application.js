// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import ToastController from "./controllers/toast_controller"

const application = Application.start()
application.register("toast", ToastController)
