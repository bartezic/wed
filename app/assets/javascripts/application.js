// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require photobox
//= require_tree .

function ready () {
  $('#myTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })
  var galleries = $('.gallery');
  if(galleries.length){
    galleries.photobox('a');
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);