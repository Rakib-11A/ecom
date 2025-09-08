import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  // static classes = ["collapsed","expanded"]
  static targets = ["aside","main"]
  connect() {
    console.log("sidebar connected.........................................");
    console.log(this.asideTarget)
    this.isCollapsed = false;
  }
  toggle() {
    this.isCollapsed = !this.isCollapsed
    if(this.isCollapsed){
      // Sidebar will collapse
      this.asideTarget.classList.remove("w-1/4")
      this.asideTarget.classList.add("w-1/12")
      this.hideLabels()
    }else{
      // Sidebar will expand
      this.asideTarget.classList.remove("w-1/12")
      this.asideTarget.classList.add("w-1/4")
      this.showLabels()
    }
  }

  hideLabels(){
    this.element.querySelectorAll(".sidebar-label").forEach(el => {
      el.style.transition = "opacity 0.2s ease-in-out"
      el.style.opacity = "0"
      setTimeout(() => el.style.display = "none", 500)
    })
  }

  showLabels(){
    this.element.querySelectorAll(".sidebar-label").forEach(el => {
      el.style.display = "block"
      el.style.transition = "opacity 0.2s ease-in-out"
      setTimeout(() => el.style.opacity = "1", 500)
    })
  }


};
