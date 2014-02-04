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
//= require jquery.cookie
//= //require calendar
//= require locale
//= require calendar2
//= require twitter/bootstrap
//= //require photobox
//= require bootstrap-datepicker
//= require jquery.mCustomScrollbar
//= require custom-select-menu.jquery
//= require search
//= //require jquery-fileupload
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require cabinet

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
  // $('#fileupload').fileupload({
  //   filesContainer: $('table.files'),
  //   uploadTemplateId: null,
  //   downloadTemplateId: null,
  //   uploadTemplate: function (o) {
  //        alert(4444);
  //       var rows = $();
  //       $.each(o.files, function (index, file) {
  //           var row = $('<tr class="template-upload fade">' +
  //               '<td><span class="preview"></span></td>' +
  //               '<td><p class="name"></p>' +
  //               (file.error ? '<div class="error"></div>' : '') +
  //               '</td>' +
  //               '<td><p class="size"></p>' +
  //               (o.files.error ? '' : '<div class="progress"></div>') +
  //               '</td>' +
  //               '<td>' +
  //               (!o.files.error && !index && !o.options.autoUpload ?
  //                   '<button class="start">Start</button>' : '') +
  //               (!index ? '<button class="cancel">Cancel</button>' : '') +
  //               '</td>' +
  //               '</tr>');
  //           row.find('.name').text(file.name);
  //           row.find('.size').text(o.formatFileSize(file.size));
  //           if (file.error) {
  //               row.find('.error').text(file.error);
  //           }
  //           rows = rows.add(row);
  //       });
  //       return rows;
  //   },
  //   downloadTemplate: function (o) {
  //        alert(5555);
  //       var rows = $();
  //       $.each(o.files, function (index, file) {
  //           var row = $('<tr class="template-download fade">' +
  //               '<td><span class="preview"></span></td>' +
  //               '<td><p class="name"></p>' +
  //               (file.error ? '<div class="error"></div>' : '') +
  //               '</td>' +
  //               '<td><span class="size"></span></td>' +
  //               '<td><button class="delete">Delete</button></td>' +
  //               '</tr>');
  //           row.find('.size').text(o.formatFileSize(file.size));
  //           if (file.error) {
  //               row.find('.name').text(file.name);
  //               row.find('.error').text(file.error);
  //           } else {
  //               row.find('.name').append($('<a></a>').text(file.name));
  //               if (file.thumbnailUrl) {
  //                   row.find('.preview').append(
  //                       $('<a></a>').append(
  //                           $('<img>').prop('src', file.thumbnailUrl)
  //                       )
  //                   );
  //               }
  //               row.find('a')
  //                   .attr('data-gallery', '')
  //                   .prop('href', file.url);
  //               row.find('.delete')
  //                   .attr('data-type', file.delete_type)
  //                   .attr('data-url', file.delete_url);
  //           }
  //           rows = rows.add(row);
  //       });
  //       return rows;
  //     }
  // });
  jQuery(function() {
    return $('#new_photo').fileupload({
      dataType: "script",
      add: function(e, data) {
        var file, types;
        types = /(\.|\/)(gif|jpe?g|png)$/i;
        file = data.files[0];
        if (types.test(file.type) || types.test(file.name)) {
          $('.progress').removeClass('hidden');
          return data.submit();
        } else {
          return alert("" + file.name + " is not a gif, jpeg, or png image file");
        }
      },
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress-bar')
          .attr('aria-valuenow', progress)
          .css('width', progress + '%');
      }
    });
  });

};

window.WedCity.ready = function() {
  ready();
  window.WedCity.calendar.init();
  window.WedCity.search.init();
  window.WedCity.cabinet.init();
};

$(document).ready(window.WedCity.ready);
$(document).on('page:load', window.WedCity.ready);
