//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.uk.js
//= require custom/feedback

function admin_ready() {
  Turbolinks.enableProgressBar();
  window.WedCity.feedback.init();
};

$(document).ready(admin_ready);
$(document).on('page:load', admin_ready);