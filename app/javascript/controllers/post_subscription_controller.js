import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="post-subscription"
export default class extends Controller {
  static values = { postId: Number, userId: Number }
  static targets = ["comments", "likes", "button"]

  connect() {
    if (this.hasLikesTarget) {
      this.likesTargetFunction();
    }

    if (this.hasButtonTarget) {
      this.buttonTargetFunction();
    }

    this.channel = createConsumer().subscriptions.create(
      { channel: "PostChannel", id: this.postIdValue },
      { received: data => {
        // Both are named rendered_string for the first partial. Like or comment both are received here.
        if (data.rendered_string.includes("💜")) {
          // Requires update for both liked_by user (current_user) and signed_in user
          this.#insertLikeCount(data.rendered_string)

          // Requires update for just liked_by user
          this.#insertButton(data.button, data.liked_by)

          // Implementation both references current_user. They represent different things depending on the file.
        } else {
          // for the comments
          this.#insertCommentAndScrollDown(data.rendered_string)
        }
      }
      }
    )
    console.log(`Subscribed to the Post with the id ${this.postIdValue}.`)
  }

  get hasLikesTarget() {
    return this.hasTarget("likes");
  }

  get hasButtonTarget() {
    return this.hasTarget("button");
  }

  #insertLikeCount(data) {
    this.likesTarget.innerHTML = data
  }

  #insertButton(button, liked_by) {
    // checks if liked_by user is the same user as the signed_in user
    if (this.userIdValue == liked_by) {
      this.buttonTarget.innerHTML = button
    }
  }

  #insertCommentAndScrollDown(data) {
    this.commentsTarget.insertAdjacentHTML("beforeend", data)
    this.commentsTarget.scrollTo(0, this.commentsTarget.scrollHeight)
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from like or post")
    this.channel.unsubscribe()
  }
}
