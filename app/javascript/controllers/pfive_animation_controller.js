import { Controller } from "@hotwired/stimulus"
import p5 from "https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.6.0/p5.min.js";

// Connects to data-controller="pfive-animation"
export default class extends Controller {
  connect() {
    console.log("hi from p5")
    // console.log(p5.createCanvas())
    // p5.setup() {
    //   createCanvas(1900, 2000);
    //   background(20,0,100);
    //   let img = createImg(
    //     'https://p5js.org/assets/img/asterisk-01.png',
    //     'the p5 magenta asterisk'
    //   );
    //   img.position(100,200);
    //   text("Welcome", 110,50);
    // }

    // let value = "#320afa";
    // function mouseMoved() {
    //   ellipse(mouseX, mouseY, 30, 35);
    // }
    // function draw() {
    //   fill(value);
    //   rect(325, 205, 490, 300);
    //   textSize(60);
    //   textAlign(CENTER);
    //   text("WELCOME", mouseX, 130+mouseX);
    //   ellipse(mouseX, mouseY, 30, 35);
    // }

    // function mousePressed() {
    //   if (value === "#320afa") {
    //     value = '#ba2f25';
    //   }
    //   else if(value === '#ba2f25'){
    //     value = "#48c722"
    //   }
    //   else if(value === "#48c722"){
    //     value = "#02bcfa"
    //   }
    //   else {
    //     value = "#320afa";
    //   }
    // }
  }
}
