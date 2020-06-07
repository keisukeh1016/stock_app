// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener('turbolinks:load', () => {
  const header = document.querySelector("header");
  const menuBar = document.querySelector("#menu_bar");
  const menuList = document.querySelector("#menu_list");
  const menuListAll = document.querySelectorAll("#menu_list>li");

  const passwordOpen = document.querySelector(".password_open");
  const passwordField = document.querySelector(".password_field");

  function menuToggle() {
    header.classList.toggle("open");
    menuList.classList.toggle("open");
  };
  
  menuBar.addEventListener("click", menuToggle);

  for(let i = 0; i < 4; i++) {
    menuListAll[i].addEventListener("click", menuToggle);
  }

  passwordOpen.addEventListener("click", () => {
    if (passwordField.getAttribute("type") == "password" ) {
      passwordField.setAttribute("type", "text");
    } else {
      passwordField.setAttribute("type", "password");
    }
  });
});