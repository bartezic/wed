window.WedCity = window.WedCity || {};

window.WedCity.calendar = {
  configs: {
    mainClass: '.rcalendar',
    monthsMap: {
      visible: [],
      exist: []
    }
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

  dateToYMD: function (date) {
    var d = date.getDate();
    var m = date.getMonth() + 1;
    var y = date.getFullYear();
    return '' + y + '-' + (m<=9 ? '0' + m : m) + '-' + (d <= 9 ? '0' + d : d);
  },

  getDays: function(date) {
    var i, occupied, current,
        days = '<w>', 
        counter = 0,
        month = date.getMonth(),
        year = date.getFullYear();

    for (i = 1; i <= this.daysBefore(date); i++) {
      days += "<e></e>";
      counter += 1;
    };

    for (i = 1; i <= this.monthLenght(date); i++) {
      if (counter % 7 === 0){ days += '</w><w>' }
      current = this.dateToYMD(new Date(year,month,i));
      occupied = this.configs.days.indexOf(current) >= 0;
      days += "<a data-day="+ current +" class="+ (occupied ? 'selected' : '') +" href='#'>" + i + "</a>";
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

  getContWidth: function() {
    return (this.elems.cont.width() > 0 ? this.elems.cont.width() : $('.container').width());
  },

  getPanelWidth: function() {
    return (this.configs.cabinet ? 0 : 160);
  },

  createMonths: function() {
    var self = this, prevWidth, i,
        date = new Date(),
        month = date.getMonth(),
        year = date.getFullYear();

    self.configs.mSize = Math.floor((self.getContWidth()-self.getPanelWidth())/220);
    
    for (i = 0; i < self.configs.mSize; i++) {
      self.elems.months.append($(self.generateMonth(month, year)));
      self.configs.monthsMap.visible.push({month: month, year: year});
      self.configs.monthsMap.exist.push({month: month, year: year});
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
        navLeft = $("<div class='nav left "+ (self.configs.pastDisabled ? 'disabled' : '') +"' title='prev month'>\
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

  checkLeftNav: function() {
    var self = this,
        date = new Date(),
        first = self.configs.monthsMap.visible.first(),
        bool;

    if(self.configs.pastDisabled){
      bool = date.getMonth() === first.month && date.getFullYear() == first.year;
      self.elems.navLeft.toggleClass('disabled', bool);
    }
  },

  moveLeft: function(e) {
    var self = this,
        map = self.configs.monthsMap,
        month = map.visible.first().month,
        year = map.visible.first().year,
        marginL = self.elems.months.css('margin-left').replace("px", "")*1;

    if (month === 0) { month = 11; year--; } 
    else { month--; };

    if(Utils.equalsObjects(map.visible.first(), map.exist.first())) {
      self.elems.months.prepend($(self.generateMonth(month, year)));
      map.exist.unshift({month: month, year: year});
    } else {
      self.elems.months.animate({'margin-left': marginL+220+'px'});  
    }

    map.visible.unshift({month: month, year: year});
    map.visible.pop();
  },

  moveRight: function(e) {
    var self = this,
        map = self.configs.monthsMap,
        month = map.visible.last().month,
        year = map.visible.last().year,
        marginL = self.elems.months.css('margin-left').replace("px", "")*1;

    if (month === 11) { month = 0; year++; } 
    else { month++; };

    if(Utils.equalsObjects(map.visible.last(), map.exist.last())) {
      self.elems.months.append($(self.generateMonth(month, year)));
      map.exist.push({month: month, year: year});
    }

    self.elems.months.animate({'margin-left': marginL-220+'px'});
    map.visible.push({month: month, year: year});
    map.visible.shift();
  },
  
  initHandlers: function (){
    var self = this;

    $(window).resize(function() {
      self.resizeCalendar();
    });

    self.elems.navLeft.click(function(e) {
      if(!$(e.currentTarget).hasClass('disabled')){
        self.elems.months.finish();
        self.moveLeft(e); 
        self.checkLeftNav(); 
      }
    });

    self.elems.navRight.click(function(e) {
      self.elems.months.finish();
      self.moveRight(e);
      self.checkLeftNav();
    });

    self.elems.months.on('click', '.days a', function(e) {
      e.preventDefault();
      if(self.configs.cabinet){
        var btn = $(this),
            selected = btn.hasClass('selected');

        if(!btn.hasClass('wait')){
          btn.addClass('wait');
          $.ajax({
            url: '/cabinet/partners/'+$('body').data('user')+'/days',
            method: 'POST',
            dataType: 'JSON',
            data: {
              day: btn.data('day'),
              add: !selected
            }
          }).done(function(res) {
            btn.toggleClass('selected', !selected);
          }).always(function(res) {
            btn.removeClass('wait');
          });
        }
      }
    });
  },

  init: function(){
    var self = this;

    this.root = window.WedCity;
    this.elems = {
      cont: $(self.configs.mainClass)
    };
    if(this.elems.cont.length > 0){
      this.configs.days = this.elems.cont.data('days');
      this.configs.cabinet = this.elems.cont.data('cabinet');
      this.configs.pastDisabled = !this.elems.cont.data('cabinet');

      this.createElems();
      this.createMonths();
      this.initHandlers();
    }
  }
};