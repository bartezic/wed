window.WedCity = window.WedCity || {};

window.WedCity.cabinet = {
  configs: {

  },

  createCallback: function(res) {
    window.location.search = 'gallery='+res.gallery.slug;
  },

  updateCallback: function(res) {
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
      self[res.type+'Callback'](res);
    });
  
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
  }
};