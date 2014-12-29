//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require custom/feedback

function admin_ready() {
  window.WedCity.feedback.init();
};

$(document).ready(admin_ready);
$(document).on('page:load', admin_ready);