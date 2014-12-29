window.WedCity = window.WedCity || {};

window.WedCity.feedback = {
  initHandlers: function(){
    $('#feedback').on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget),
          name = button.data('name'),
          email = button.data('email'),
          modal = $(this),
          name_el = modal.find('form input#feedback_name'),
          email_el = modal.find('form input#feedback_email');
      if(name_el.val() == ''){ name_el.val(name) };
      if(email_el.val() == ''){ email_el.val(email) };
    })
  },

  init: function() {
    this.initHandlers()
  }
};

