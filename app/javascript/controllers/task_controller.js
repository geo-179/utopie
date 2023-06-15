import { Controller } from "@hotwired/stimulus"
import p5 from 'p5';

export default class TaskController extends Controller {
    static targets = ["test"]
    connect() {
      console.log("hello world")
      console.log(this.testTarget)
    }
}
