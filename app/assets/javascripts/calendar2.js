window.WedCity = window.WedCity || {};

window.WedCity.ready = function() {
  window.WedCity.calendar.init();
};

window.WedCity.calendar = {
  configs: {
    mainClass: '.rcalendar'
  },

  weekDays: function() {
    return $.map(this.root.l.day.abbr, function(n) {
      return ('<i>'+ n +'</i>');
    }).join('\n');
  },

  daysBefore: function(date) {
    return (date.getDay() - date.getDate()%7 + 14)%7
  },

  monthLenght: function(date) {
    return new Date(date.getFullYear(), date.getMonth()+1, 0).getDate();
  },

  getDays: function(date) {
    var date, days = '<w>', i, counter = 0;

    for(i = 1; i <= this.daysBefore(date); i++){
      days += "<e></e>";
      counter += 1;
    };

    for (i = 1; i <= this.monthLenght(date); i++) {
      if (counter % 7 === 0){ days += '</w><w>' }
      days += "<a href='#'>" + i + "</a>";
      counter += 1;
    };

    days += '</w>'

    return days;
  },

  generateMonth: function(month, year){
    var date;

    if (month && year) {
      date = new Date(year,month,1);
    } else {
      date = new Date();
    };

    return  "<div class='month'>\
              <div class='header'>" + window.WedCity.l.month.name[date.getMonth()] + "    " + date.getFullYear() + "</div>\
              <div class='body'>\
                <div class='days'>" + this.getDays(date); + "</div>\
              </div>\
            </div>";
  },

  createMonths: function() {
    var self = this,
        month = self.generateMonth();

        console.log(month)
    
    self.elems.monthsWrap.append(month);
  },

  createElems: function(){
    var self = this,
        navLeft = $("<div class='nav left' title='prev month'>\
                    <span class='glyphicon glyphicon-chevron-left'></span>\
                  </div>"),
        navRight = $("<div class='nav right' title='next month' >\
                    <span class='glyphicon glyphicon-chevron-right'></span>\
                  </div>"),
        weekDays = $("<div class='day_names left'>" + self.weekDays() + "</div>\
                    <div class='day_names right'>" + self.weekDays() + "</div>"),
        viewport = $("<div class='viewport'></div>"),
        monthsWrap = $("<div class='months'></div>");

    viewport.append(monthsWrap);
    self.elems.cont.append([navLeft, navRight, weekDays, viewport]);

    $.extend(self.elems, {
      navLeft: navLeft,
      navRight: navRight,
      weekDays: weekDays,
      viewport: viewport,
      monthsWrap: monthsWrap
    });
  },
  
  initHandlers: function (){

  },

  init: function(){
    var self = this;

    this.root = window.WedCity;
    this.elems = {
      cont: $(self.configs.mainClass)
    };

    this.createElems();
    this.createMonths();
    this.initHandlers();
  }
};

$(document).ready(window.WedCity.ready);
$(document).on('page:load', window.WedCity.ready);