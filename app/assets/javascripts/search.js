window.WedCity = window.WedCity || {};

window.WedCity.search = {
  configs: {

  },

  initHandlers: function (){
    var self = this;

    self.elems.form.change(function(e){
      self.elems.form.submit();
    });

    self.elems.sliderForm.submit(function(e) {
      //e.preventDefault();

      var elems = $(this).find('input, select');

      $.each(elems, function(i) {
        if((elems[i].value === '') || (['commit', 'utf8'].indexOf(elems[i].name) >= 0)){
          elems[i].name = null;
        }
      });

      return true;
    });

    self.elems.order.change(function(e) {
      var val = $(this).closest('.ordering').find('input').val();
      document.cookie = 'order='+val+';'  
      self.elems.form.submit();
    });
    
    // self.elems.resetBtn.click(function(){
    //   self.elems.form[0].reset();
    // });

    // self.elems.location.change(function(){
    //   self.elems.form.submit();
    // });
  },

  init: function(){
    var self = this;

    this.root = window.WedCity;
    this.elems = {
      sliderForm: $('form.search-form'),
      form: $('.search-form form'),
      // resetBtn: $('.search-form form .reset'),
      category: $('.search-form .service input'),
      location: $('.search-form .location input'),
      date: $('.search-form .date input'),
      order: $('.ordering select')
    };
    
    this.initHandlers();
  }
};