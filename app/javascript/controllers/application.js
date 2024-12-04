import { Application } from "@hotwired/stimulus";
import ToastController from "./controllers/toast_controller"; // Adjust the path as necessary

const application = Application.start();
application.register("toast", ToastController);

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
