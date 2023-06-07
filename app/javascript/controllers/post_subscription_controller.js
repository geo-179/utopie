import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="post-subscription"
export default class extends Controller {
  static values = { postId: Number }
  static targets = ["likes"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "PostChannel", id: this.postIdValue },
      { received: data =>
        console.log(data)

        // this.#insertCommentAndScrollDown(data)
      }
    )
    console.log(`Subscribed to the Post with the id ${this.postIdValue}.`)
  }

  // #insertCommentAndScrollDown(data) {
  //   this.commentsTarget.insertAdjacentHTML("beforeend", data)
  //   this.commentsTarget.scrollTo(0, this.commentsTarget.scrollHeight)
  // }

  // resetForm(event) {
  //   event.target.reset()
  // }j

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
