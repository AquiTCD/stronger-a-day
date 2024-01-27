import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Import and register all TailwindCSS Components
import { Modal, Slideover } from "tailwindcss-stimulus-components"
application.register('modal', Modal)
application.register('slideover', Slideover)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
