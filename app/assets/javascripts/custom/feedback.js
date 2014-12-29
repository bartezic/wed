window.WedCity = window.WedCity || {};

window.WedCity.feedback = {
  initHandlers: function(){
    $('#feedback').on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget);
      var name = button.data('name');
      var email = button.data('email');
      var modal = $(this);
      modal.find('form input#feedback_name').val(name);
      modal.find('form input#feedback_email').val(email);
    })
  },

  init: function() {
    this.initHandlers()
  }
};

