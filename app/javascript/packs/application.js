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
  // スマホ用メニューバー
  const header = document.querySelector("header");
  const menuBar = document.querySelector("#menu_bar");
  const menuList = document.querySelector("#menu_list");
  const menuListAll = document.querySelectorAll("#menu_list>li");
  function menuToggle() {
    header.classList.toggle("open");
    menuList.classList.toggle("open");
  };
  if ( menuBar !== null ) {
    menuBar.addEventListener("click", menuToggle);
    for(let i = 0; i < 4; i++) {
      menuListAll[i].addEventListener("click", menuToggle);
    }
  }
  
  // フォームのパスワード表示
  const passwordOpen = document.querySelector(".password_open");
  const passwordField = document.querySelector(".password_field");
  if ( passwordOpen !== null ) {
    passwordOpen.addEventListener("click", () => {
      if (passwordField.getAttribute("type") == "password" ) {
        passwordField.setAttribute("type", "text");
      } else {
        passwordField.setAttribute("type", "password");
      }
    });
  }
  
  // アカウント削除ボタン表示
  const destroyBar = document.querySelector("#destroy_open");
  const destroyButton = document.querySelector("#destroy_button");
  if ( destroyBar !== null ) {
    destroyBar.addEventListener("click", () => {
      destroyBar.textContent = "↓";
      destroyButton.classList.add("open");
    });
  }

  // マイページ編集
  const openButtons = document.querySelectorAll(".open_button");
  const closeButtons = document.querySelectorAll(".close_button");
  const portfolioHoldings = document.querySelectorAll(".portfolio_holding");
  const portfolioUpdates = document.querySelectorAll(".portfolio_update");
  const portfolioDeletes = document.querySelectorAll(".portfolio_delete");

  for (let i = 0; i < openButtons.length; i++) {
    openButtons[i].addEventListener("click", () => {
      openButtons[i].classList.remove("open");
      closeButtons[i].classList.add("open");
      portfolioHoldings[i].classList.remove("open");
      portfolioUpdates[i].classList.add("open");
      portfolioDeletes[i].classList.add("open");
    });

    closeButtons[i].addEventListener("click", () => {
      openButtons[i].classList.add("open");
      closeButtons[i].classList.remove("open");
      portfolioHoldings[i].classList.add("open");
      portfolioUpdates[i].classList.remove("open");
      portfolioDeletes[i].classList.remove("open");
    });
  }

});