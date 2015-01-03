//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require cocoon
//= require external/photobox
//= require external/Sortable.min

//= require custom/utils
//= require custom/locale
//= require custom/calendar
//= require custom/feedback

window.WedCity = window.WedCity || {};

window.WedCity.cabinet = {
  configs: {

  },

  createGalleryCallback: function(res) {
    if (res.gallery) {
      window.location.search = 'gallery='+res.gallery.slug;
    } else if (res.errors) {
      $('.flashes').append('\
        <div class="alert alert-danger alert-dismissable">\
          <button class="close" data-dismiss="alert" data-hidden="" type="button">×</button>\
          Додайте назву галереї.\
        </div>')
    }
  },

  updateGalleryCallback: function(res) {
    var self = this;

    self.elems.title.text(res.gallery.name);
    self.elems.description.text(res.gallery.description);
    self.elems.hideEdit.click();
  },

  initHandlers: function (){
    var self = this;

    self.elems.showEdit.click(function() {
      self.elems.showEdit.addClass('hidden');
      self.elems.title.addClass('hidden');
      self.elems.description.addClass('hidden');
      self.elems.hideEdit.removeClass('hidden');
      self.elems.galleryFormWrap.show("easeOutQuint");
    });

    self.elems.hideEdit.click(function() {
      self.elems.hideEdit.addClass('hidden');
      self.elems.galleryFormWrap.hide("easeOutQuint");
      self.elems.title.removeClass('hidden');
      self.elems.description.removeClass('hidden');
      self.elems.showEdit.removeClass('hidden');
    });

    self.elems.galleryForm.bind('ajax:complete', function(event, xhr) {
      var res = $.parseJSON(xhr.responseText);
      self[res.type+'GalleryCallback'](res);
    });

    $('form.show-callendar').change(function(e) {
      $(this).submit();
    });
    
    $('#new_photo').fileupload({
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
  
  },

  initVideosGallery: function() {
    var galleries = $('.videos');
    if(galleries.length !== 0){
      galleries.photobox('.video > a');
    }
  },

  initSorting: function() {
    var sortable, el, sortes = [{
      wrap: 'photos',
      item: '.photo'
    },{
      wrap: 'videos',
      item: '.video'
    },{
      wrap: 'galleries',
      item: '.gallery'
    }];

    for (i = 0; i < sortes.length; i++) {
      (function(sorte){
        el = document.getElementsByClassName(sorte.wrap)[0];
        if (el) {
          sortable = Sortable.create(el, {
            handle: '.move',
            draggable: sorte.item,
            animation: 150,
            ghostClass: 'drop',
            onSort: function (evt) {
              $(el).addClass('loadmask');
              $.ajax({
                url: '/cabinet/partners/sort',
                method: 'POST',
                dataType: 'JSON',
                data: {
                  type: sorte.wrap,
                  ids: sortable.toArray()
                }
              }).always(function(res) {
                $(el).removeClass('loadmask');
              });
            }
          });
        }
      })(sortes[i]);
    }
  },

  initPhotosGallery: function() {
    var galleries = $('.photos');
    if(galleries.length !== 0){
      galleries.photobox('.photo > a');
    }
  },

  init: function(){
    var self = this;

    this.root = window.WedCity;
    this.elems = {
      showEdit: $('.actions .show-edit'),
      hideEdit: $('.actions .hide-edit'),
      galleryFormWrap: $('.edit-form'),
      galleryForm: $('.edit-form form'),
      title: $('.gallery-open .title'),
      description: $('.gallery-open .description')
    };
    
    this.initHandlers();
    this.initVideosGallery();
    this.initPhotosGallery();
    this.initSorting();
  }
};

window.WedCity.ready = function() {
  Turbolinks.enableProgressBar();
  window.WedCity.cabinet.init();
  window.WedCity.calendar.init();
  window.WedCity.feedback.init();
};

$(document).ready(window.WedCity.ready);
$(document).on('page:load', window.WedCity.ready);
