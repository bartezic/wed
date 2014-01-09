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
//= require prototypes
//= //require calendar
//= require locale
//= require calendar2
//= require twitter/bootstrap
//= //require photobox
//= require bootstrap-datepicker
//= require jquery.mCustomScrollbar
//= require custom-select-menu.jquery
//= require search

function ready () {
  $('#myTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })

  $('input#datepicker').datepicker({
    startDate: "0d",
    language: window.WedCity.locale,
    format: 'dd/mm/yyyy',
    autoclose: true
  }).on('changeDate', function(e){
    var d = e.date.getDate();
    var m = e.date.getMonth() + 1;
    var y = e.date.getFullYear();
    var r = '' + (d <= 9 ? '0' + d : d) + '/' + (m<=9 ? '0' + m : m) + '/' + y + '';
    $('.search-form .date label').text(r);
  });

  $('.search-form .date').click(function(e) {
    $('input#datepicker').datepicker('show');
  });

  $('.location select, .posluga select').customSelectMenu({
    menuClass : 'custom-select-menu',
    openedClass : 'opened',
    selectedClass : 'selected',
    selectionMadeClass : 'selection-made'
  });

  $('.ordering select').customSelectMenu({
    menuClass : 'custom-select-menu',
    openedClass : 'opened',
    selectedClass : 'selected',
    selectionMadeClass : 'selection-made'
  });

  $('form.show-callendar').change(function(e) {
    $(this).submit();
  })

  // $('.locationpicker ul li').click(function(e) {
  //   // $('input#locationpicker').val($(this).text());
  //   $(this).siblings('li').removeClass('selected');
  //   $(this).addClass('selected');
  //   $('.search-form .location span').text('('+ $(this).text() +')');
  // });

  // $('.search-form .location').on('click', function(e) {
  //   $('.locationpicker ul').toggleClass('hidden');
  // });
  // var galleries = $('.gallery');
  // if(galleries.length !== 0){
  //   galleries.photobox('a');
  // }
};

window.WedCity.ready = function() {
  ready();
  window.WedCity.calendar.init();
  window.WedCity.search.init();
};

$(document).ready(window.WedCity.ready);
$(document).on('page:load', window.WedCity.ready);
