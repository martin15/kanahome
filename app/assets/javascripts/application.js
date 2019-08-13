// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require ckeditor/init
//= require_tree .

// document on ready functions
$(document).ready(function () {
  // my variables
  var nav = $('#nav'),
      bars = $('#bars'),
      menu = $('#menu'),
      up = $('#up'),
      prevOffset = 0,
      mainSection = $('.main-section'),
      mainSectionLength = mainSection.length,
      links = $('#menu li'),
      flag = 0,
      flag2 = 0,
      lastI = 100,
      body = $('body');
      myWindow = $(window);
  
  $(".faq-nav a").click(function() {
    $(".faq-nav a").removeClass("active");
    $(this).addClass("active");
  });

  // menu bars on click
  function barsClicked() {
    bars.toggleClass('clicked');
    menu.slideToggle(300);
  }

  bars.on('click', barsClicked);

  // up icon on click
  $('#up').on('click', function () {
      $('html, body').animate({
          scrollTop: 0
      }, {
          duration: 1800,
          easing: 'easeInOutQuint'
      });
  });

  // on resize functions
  myWindow.on('resize', function () {
    if (bars.css('display') === 'block') {
        menu.css('display', 'none');
        bars.removeClass('clicked');
    } else {
        menu.css('display', 'block');
    }
  });

  // change navbar active link while scrolling
  if (flag === 0 && mainSectionLength) {
    flag = 1;
    flag2 = 0;
    for (let i = mainSectionLength - 1; i >= 0; i--) {
        if (myWindow.scrollTop() >= mainSection.eq(i).offset().top) {
            if (i != lastI) {
                links.eq(i + 1).addClass('active').siblings().removeClass('active');
                lastI = i;
            }
            flag2 = 1;
            break;
        }
    }
    if (flag2 === 0) {
        links.eq(0).addClass('active').siblings().removeClass('active');
        lastI = -1;
    }
    flag = 0;
  }

  $('a[href*=\\#]').bind('click', function(e) {
    e.preventDefault(); // prevent hard jump, the default behavior

    var target = $(this).attr("href").replace('/',''); // Set the target as variable

    // perform animated scrolling by getting top-position of target-element and set it as scroll target
    if($('html, body').has(target).length == 0 ){
      window.location.href = $(this).attr("href");
    }else{
      $('html, body').animate({
        scrollTop: $(target).offset().top - 80
      }, 600);
    }

    return false;
  });

});
