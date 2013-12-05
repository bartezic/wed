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

    for (i = 1; i <= this.daysBefore(date); i++) {
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
    var date = new Date(year,month,1);

    return  "<div class='month' data-month='" + month + "' data-year='" + year + "'>\
              <div class='header'>" + window.WedCity.l.month.name[date.getMonth()] + "    " + date.getFullYear() + "</div>\
              <div class='days'>" + this.getDays(date); + "</div>\
            </div>";
  },

  createMonths: function() {
    var self = this, prevWidth, i,
        date = new Date(),
        month = date.getMonth(),
        year = date.getFullYear();

    self.configs.mSize = Math.floor(($('.container').width()-160)/220);
    
    for (i = 0; i < self.configs.mSize; i++) {
      self.elems.months.append($(self.generateMonth(month, year)));
      if (month === 11) {
        month = 0;
        year++;
      } else {
        month++;
      };
    };

    self.elems.viewport.width(self.configs.mSize*220);
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
        months = $("<div class='months'></div>");

    viewport.append(months);
    self.elems.cont.append([navLeft, navRight, weekDays, viewport]);

    $.extend(self.elems, {
      navLeft: navLeft,
      navRight: navRight,
      weekDays: weekDays,
      viewport: viewport,
      months: months
    });
  },

  resizeCalendar: function() {
    var self = this,
        mSize = Math.floor(($('.container').width()-160)/220);
  },
  
  initHandlers: function (){
    var self = this;

    $(window).resize(function() {
      self.resizeCalendar();
    });
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