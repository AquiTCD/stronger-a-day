import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Import and register all TailwindCSS Components
import { Alert, Modal, Popover, Slideover } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('modal', Modal)
application.register('popover', Popover)
application.register('slideover', Slideover)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
