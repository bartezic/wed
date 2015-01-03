window.WedCity = window.WedCity || {};

window.WedCity.search = {
  configs: {

  },

  initHandlers: function (){
    var self = this;

    self.elems.lineForm.submit(function(e) {
      if($(this).find('input[name=category_id]')[0].value === ''){
        $(this).find('.posluga').addClass('invalid');
        return false;
      }


      $(this).find('input, select').each(function() {
        if((this.value === '') || (['commit', 'utf8'].indexOf(this.name) >= 0)){
          this.name = null;
        }
      });

      return true;
    });

    self.elems.sideform.change(function(e) {
      $.cookie('order', $(this).find('.ordering input').val(), { path: '/' });
      self.elems.sideform.submit();
    });
  },

  init: function(){
    var self = this;

    this.root = window.WedCity;
    this.elems = {
      lineForm: $('form.search-form'),
      sideform: $('.search-form form')
    };
    
    this.initHandlers();
  }
};