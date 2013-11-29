function new_ready () {
  var DefaultMomentLocale = {
    localeName: 'en',
    locale: {
      'month': {
        'name': [null, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        'gen': [null, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        'abbr': [null, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        'abbr2': [null, 'Jan.', 'Feb.', 'Mar.', 'Apr.', 'May.', 'Jun.', 'Jul.', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.']
      },
      'day': {
        'name': [null, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        'abbr': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        'part': {
          'night': 'night',
          'morning': 'morning',
          'day': 'day',
          'evening': 'evening'
        }
      }
    }
  };

  function Moment(date) {
    var _size = function(obj) {
      var key, size;
      size = 0;
      for (key in obj) {
        if (obj.hasOwnProperty(key)) {
          size++;
        }
      }
      return size;
    };
    
    this.locales = {};
    this.localeName = null;
    this.currentLocale = null;

    if (Object.keys(this.locales).length === 0) {
      this.locales[DefaultMomentLocale.localeName] = DefaultMomentLocale.locale;
      this.localeName = DefaultMomentLocale.localeName;
      this.currentLocale = DefaultMomentLocale.locale;
    }

    this.t = this.currentLocale;
    this.parse(date);
  };

  Moment.prototype = {
    month_name: function() {
      return this.t.month.name[this.month];
    },
    day_name: function() {
      return this.t.day.name[this.day_of_week()];
    },
    day_of_week: function(date) {
      var day;
      if (date == null) {
        date = this.date;
      }
      day = date.getDay();
      return day = day === 0 ? 7 : day;
    }, 
    to_a: function() {
      return [this.year, this.month, this.day, this.hours, this.mins, this.secs, this.ms, this.offset];
    },
    toMonthString: function() {
      return "" + this.year + "." + this.month;
    },
    toDayString: function() {
      return "" + this.year + "." + this.month + "." + this.day;
    },
    setYear: function(y) {
      var d = this.date;
      d.setYear(y);
      return this.parse(d);
    },
    setMonth: function(m) {
      var d = this.date;
      d.setMonth(m - 1);
      return this.parse(d);
    },
    setDay: function(_d) {
      var d = this.date;
      d.setDate(_d);
      return this.parse(d);
    },
    setHours: function(h) {
      var d = this.date;
      d.setHours(h);
      return this.parse(d);
    },
    setMins: function(m) {
      var d = this.date;
      d.setMinutes(m);
      return this.parse(d);
    },
    setSecs: function(s) {
      var d = this.date;
      d.setSeconds(s);
      return this.parse(d);
    },
    setMs: function(ms) {
      var d = this.date;
      d.setMilliseconds(ms);
      return this.parse(d);
    },
    setUnix: function(sec) {
      return this.parse(sec);
    },
    setUnixMs: function(ms) {
      return this.parseDate(new Date(ms));
    },
    setDateByInstances: function() {
      var date, month;
      date = new Date(0);
      month = this.month > 0 ? this.month - 1 : this.month;
      date.setFullYear(this.year);
      date.setMonth(month);
      date.setDate(this.day);
      date.setHours(this.hours);
      date.setMinutes(this.mins);
      date.setSeconds(this.secs);
      date.setMilliseconds(this.ms);
      return this.date = date;
    },
    _year: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getFullYear();
    },
    _month: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getMonth() + 1;
    },
    _day: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getDate();
    },
    _hours: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getHours();
    },
    _mins: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getMinutes();
    },
    _secs: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getSeconds();
    },
    _ms: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getMilliseconds();
    },
    _offset: function(date) {
      if (date == null) {
        date = new Date;
      }
      return -(date.getTimezoneOffset() / 60);
    },
    _unix_ms: function(date) {
      if (date == null) {
        date = new Date;
      }
      return date.getTime();
    },
    parse: function(date) {
      var empty;
      if (!date) {
        this.parseDate();
      }
      if (typeof date === 'string') {
        empty = date === '';
        if (empty) {
          this.parseDate();
        }
        if (!empty) {
          this.parseString(date);
        }
      }
      if (typeof date === 'number') {
        this.parseNumber(date * 1000);
      }
      if (typeof date === 'object') {
        if (date instanceof Date) {
          return this.parseDate(date);
        }
        if (date instanceof Array) {
          return this.parseArray(date);
        }
        if (date instanceof Object) {
          return this.parseHash(date);
        }
        if (date instanceof Moment) {
          return new Moment(date.to_a());
        }
      }
      return this;
    },
    parseDate: function(date) {
      if (date == null) {
        date = new Date;
      }
      this.date = date;
      this.year = this._year(this.date);
      this.month = this._month(this.date);
      this.day = this._day(this.date);
      this.hours = this._hours(this.date);
      this.mins = this._mins(this.date);
      this.secs = this._secs(this.date);
      this.ms = this._ms(this.date);
      this.offset = this._offset(this.date);
      this.unix_ms = this._unix_ms(this.date);
      this.unix = Math.round(this.unix_ms / 1000);
      return this;
    },
    parseArray: function(date) {
      var _date;
      if (date.length === 0) {
        return this.parseDate();
      }
      _date = new Date(0);
      this.year = date[0] ? date[0] : this._year(_date);
      this.month = date[1] ? date[1] : 1;
      this.day = date[2] ? date[2] : 1;
      this.hours = date[3] ? date[3] : 0;
      this.mins = date[4] ? date[4] : 0;
      this.secs = date[5] ? date[5] : 0;
      this.ms = date[6] ? date[6] : 0;
      this.offset = date[7] ? date[7] : this._offset(_date);
      this.setDateByInstances();
      return this.parseDate(this.date);
    },
    parseHash: function(date) {
      var empty_hash, _date;
      empty_hash = !date['year'] && !date['month'] && !date['day'] && !date['hours'] && !date['mins'] && !date['secs'] && !date['ms'];
      if (empty_hash) {
        return this.parseDate();
      }
      _date = new Date(0);
      this.year = date['year'] ? date['year'] : this._year(_date);
      this.month = date['month'] ? date['month'] : 1;
      this.day = date['day'] ? date['day'] : 1;
      this.hours = date['hours'] ? date['hours'] : 0;
      this.mins = date['mins'] ? date['mins'] : 0;
      this.secs = date['secs'] ? date['secs'] : 0;
      this.ms = date['ms'] ? date['ms'] : 0;
      this.offset = date['offset'] ? date['offset'] : this._offset(_date);
      this.setDateByInstances();
      return this.parseDate(this.date);
    },
    parseString: function(date) {
      var _date;
      if (date.match('-') && date.match(':') && !date.match('T')) {
        date = date.replace(/-/g, '/');
      }
      if (date.match('\\.') && !date.match(':')) {
        return this.parseArray(date.split('.'));
      }
      _date = new Date(Date.parse(date));
      return this.parseDate(_date);
    },
    parseNumber: function(date) {
      var _date = new Date(date);
      return this.parseDate(_date);
    },
    max_days: 42,
    shift_months: function(n) {
      var shift;
      shift = this.month + n;
      shift = shift <= 0 ? shift - 1 : shift;
      return new Moment([this.year, shift]);
    },
    today: function(M2) {
      return this.year === M2.year && this.month === M2.month && this.day === M2.day;
    },
    month_length: function(year, month) {
      if (year == null) {
        year = this.year;
      }
      if (month == null) {
        month = this.month;
      }
      return new Date(year, month, 0).getDate();
    },
    prev_month_length: function() {
      return new Date(this.year, this.month - 1, 0).getDate();
    }
  }

  Moment.prototype.next_month_length = function() {
    return new Date(this.year, this.month + 1, 0).getDate();
  };

  Moment.prototype.first_day_of_month = function() {
    var day;
    day = new Date(this.year, this.month - 1, 1).getDay();
    day = day === 0 ? 7 : day;
    return day;
  };

  Moment.prototype.last_day_of_month = function() {
    var day, length;
    length = this.month_length(this.year, this.month);
    day = new Date(this.year, this.month - 1, length).getDay();
    day = day === 0 ? 7 : day;
    return day;
  };

  Moment.prototype.days_before_month = function() {
    return this.first_day_of_month() - 1;
  };

  Moment.prototype.days_after_month = function() {
    return this.max_days - (this.days_before_month() + this.month_length());
  };


  Moment.prototype.part_of_day = function() {
    return this.is_night() ? this.t.day.part.night : this.is_morning() ? this.t.day.part.morning : this.is_day() ? this.t.day.part.day : this.t.day.part.evening;
  };

  Moment.prototype.is_night = function() {
    return this.hours < 6;
  };

  Moment.prototype.is_morning = function() {
    return this.hours >= 6 && this.hours < 12;
  };

  Moment.prototype.is_day = function() {
    return this.hours >= 12 && this.hours < 18;
  };

  Moment.prototype.is_evening = function() {
    return this.hours >= 18;
  };

  Moment.prototype.is_weekend = function() {
    var day;
    day = this.day_of_week();
    return day === 6 || day === 7;
  };

  Moment.prototype.is_monday = function() {
    return this.day_of_week() === 1;
  };

  Moment.prototype.is_tuesday = function() {
    return this.day_of_week() === 2;
  };

  Moment.prototype.is_wednesday = function() {
    return this.day_of_week() === 3;
  };

  Moment.prototype.is_thursday = function() {
    return this.day_of_week() === 4;
  };

  Moment.prototype.is_friday = function() {
    return this.day_of_week() === 5;
  };

  Moment.prototype.is_saturday = function() {
    return this.day_of_week() === 6;
  };

  Moment.prototype.is_sunday = function() {
    return this.day_of_week() === 7;
  };


  Moment.prototype.less = function(M) {
    if (M == null) {
      M = new Date;
    }
    return this.unix_ms < M.unix_ms;
  };

  Moment.prototype.less_or_equal = function(M) {
    if (M == null) {
      M = new Date;
    }
    return this.unix_ms <= M.unix_ms;
  };

  Moment.prototype.equal = function(M) {
    if (M == null) {
      M = new Date;
    }
    return this.unix_ms === M.unix_ms;
  };

  Moment.prototype.greater_or_equal = function(M) {
    if (M == null) {
      M = new Date;
    }
    return this.unix_ms >= M.unix_ms;
  };

  Moment.prototype.greater = function(M) {
    if (M == null) {
      M = new Date;
    }
    return this.unix_ms > M.unix_ms;
  };

  Moment.prototype.l = function(M) {
    return this.less(M);
  };

  Moment.prototype.loe = function(M) {
    return this.less_or_equal(M);
  };

  Moment.prototype.e = function(M) {
    return this.equal(M);
  };

  Moment.prototype.goe = function(M) {
    return this.greater_or_equal(M);
  };

  Moment.prototype.g = function(M) {
    return this.greater(M);
  };


  Moment.prototype.shift_years = function(n) {
    return new Moment([this.year + n, this.month]);
  };

  Moment.prototype.shift_months = function(n) {
    var shift;
    shift = this.month + n;
    shift = shift <= 0 ? shift - 1 : shift;
    return new Moment([this.year, shift]);
  };

  Moment.prototype.shift_weeks = function(n) {
    var hours, mins, secs, weeks;
    secs = 60;
    mins = 60;
    hours = 24;
    weeks = secs * mins * hours * 7 * n;
    return new Moment(this.unix + weeks);
  };

  Moment.prototype.shift_days = function(n) {
    var days, hours, mins, secs;
    secs = 60;
    mins = 60;
    hours = 24;
    days = secs * mins * hours * n;
    return new Moment(this.unix + days);
  };

  Moment.prototype.shift_hours = function(n) {
    var hours, mins, secs;
    secs = 60;
    mins = 60;
    hours = secs * mins * n;
    return new Moment(this.unix + hours);
  };

  Moment.prototype.shift_mins = function(n) {
    var mins, secs;
    secs = 60;
    mins = secs * n;
    return new Moment(this.unix + mins);
  };

  Moment.prototype.shift_secs = function(n) {
    return new Moment(this.unix + n);
  };


  function OrderedHash(array) {
    if (array == null) {
      array = [];
    }
    this.data = [];
    if (array.length > 0) {
      this.data = array;
    }
    this.get = function() {
      return this.data;
    };

    this.push = function(obj) {
      return this.data.push(obj);
    };

    this.deleteByKey = function(key) {
      var index, item, name, value, _ref;
      _ref = this.data;
      for (index in _ref) {
        item = _ref[index];
        for (name in item) {
          value = item[name];
          if (name.toString() === key.toString()) {
            delete this.data[index];
          }
        }
      }
      return this.data = this.data.filter(function(e) {
        return e;
      });
    };

    this.sortByKey = function(reverse) {
      if (reverse == null) {
        reverse = false;
      }
      return this.data.sort(function(a, b) {
        var akey, anum, bkey, bnum, key, r, value, _ref;
        for (key in a) {
          value = a[key];
          akey = key;
        }
        for (key in b) {
          value = b[key];
          bkey = key;
        }
        anum = parseInt(akey, 10);
        bnum = parseInt(bkey, 10);
        if (typeof anum === 'number' && typeof bnum === 'number') {
          akey = anum;
          bkey = bnum;
        }
        if (reverse) {
          _ref = [bkey, akey], akey = _ref[0], bkey = _ref[1];
        }
        return r = akey > bkey ? 1 : akey < bkey ? -1 : 0;
      });
    };

    this.sortByValue = function(reverse) {
      if (reverse == null) {
        reverse = false;
      }
      return this.data.sort(function(a, b) {
        var avalue, bvalue, key, r, value, _ref;
        for (key in a) {
          value = a[key];
          avalue = value.toString().toLowerCase();
        }
        for (key in b) {
          value = b[key];
          bvalue = value.toString().toLowerCase();
        }
        if (reverse) {
          _ref = [bvalue, avalue], avalue = _ref[0], bvalue = _ref[1];
        }
        return r = avalue > bvalue ? 1 : avalue < bvalue ? -1 : 0;
      });
    };
  };

  function CalendarItems(calendar) {
    this.calendar = calendar;
    this.id = this.calendar.id;
    this.block = this.calendar.block;
    this.current_month = null;
    this.first_month = function() {
      return $("" + this.id + " .months .month").first();
    };
    this.month_width = function() {
      return this._mwidth = this._mwidth ? this._mwidth : this.first_month().outerWidth(true);
    };
    this.viewport = function() {
      return this._viewport = this._viewport ? this._viewport : $("" + this.id + " .viewport");
    };
    this.box = function() {
      return this._box = this._box ? this._box : $("" + this.id + " .calendar");
    };
    this.months = function() {
      return this._month = this._month ? this._month : $("" + this.id + " .months");
    };
    this.left = function() {
      return this._left = this._left ? this._left : $("" + this.id + " .nav.left");
    };
    this.right = function() {
      return this._right = this._right ? this._right : $("" + this.id + " .nav.right");
    };
    this.days = function() {
      return $("" + this.id + " .months .month a");
    };
  };

  function CalendarView(calendar) {
    this.calendar = calendar;
    this.id = this.calendar.id;
    this.options = this.calendar.options;
    this.template = function(body) {
      return "<div class='calendar'>\
                <div class='nav left' title='prev month'>\
                  <span class='glyphicon glyphicon-chevron-left'></span>\
                </div>\
                <div class='day_names left'>" + this.days_names() + "</div>\
                <div class='day_names right'>" + this.days_names() + "</div>\
                <div class='nav right' title='next month' >\
                  <span class='glyphicon glyphicon-chevron-right'></span>\
                </div>\
                <div class='viewport'>\
                  <div class='months'>" + (body || '') + "</div>\
                </div>\
              </div>";
    };
    this.days_names = function() {
      return $.map(this.calendar.options.locale.day.abbr, function(n, i) {
        return ('<i>'+ n + '</i>');
      }).join('\n');
    };
    this.days = function(M) {
      var current_day, days, empty_after, empty_before, i, month_length, mstart, n, prev_length, stamp, today, weekend, _i, _j, _k, _ref, wk;
      days = '<w>';
      wk = 0;
      today = new Moment;
      empty_before = M.days_before_month();
      prev_length = M.prev_month_length();
      mstart = prev_length - empty_before;
      if (empty_before > 0) {
        for (i = _i = 0, _ref = empty_before - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          n = mstart + i;
          days += "<e></e>";
          wk += 1;
          if (wk % 7 === 0){
            days += '</w><w>'
          }
        }
      }
      month_length = M.month_length();
      for (i = _j = 1; 1 <= month_length ? _j <= month_length : _j >= month_length; i = 1 <= month_length ? ++_j : --_j) {
        current_day = new Moment([M.year, M.month, i]);
        weekend = current_day.is_weekend() ? " class='weekend' " : '';
        stamp = "data-date='" + (current_day.toDayString()) + "'";
        if (current_day.today(this.options.init)) {
          days += "<a href='#' class='today' " + stamp + ">" + i + "</a>";
          wk += 1;
        } else {
          if (this.options.border.left && current_day.less(this.options.border.left)) {
            days += "<i " + stamp + ">" + i + "</i>";
          } else if (this.options.border.right && current_day.greater(this.options.border.right)) {
            days += "<i " + stamp + ">" + i + "</i>";
          } else {
            days += "<a href='#' " + stamp + weekend + ">" + i + "</a>";
          }
        }
        wk += 1;
        if (wk % 7 === 0){
          days += '</w><w>'
        }
      }
      // empty_after = M.days_after_month();
      // for (i = _k = 1; 1 <= empty_after ? _k <= empty_after : _k >= empty_after; i = 1 <= empty_after ? ++_k : --_k) {
      //   days += "<s>" + i + "</s>";
      //   wk += 1;
      //   if (wk % 7 === 0){
      //     days += '</w><w>'
      //   }
      // }
      days += '</w>';
      return days;
    };

    this.month = function(M) {
      return "<div class='month' data-date='" + (M.toMonthString()) + "'>\
                <div class='header'>" + (M.month_name()) + "    " + M.year + "</div>\
                <div class='body'>\
                  <div class='days'>" + (this.days(M)) + "</div>\
                </div>\
              </div>";
    };
  };

  function Calendar(id, opts) {
    var i, _i, _ref;
    this.id = id;
    this.options = opts;
    this.block = $(id);
    this.items = new CalendarItems(this);
    this.view = new CalendarView(this);
    this.block.append(this.view.template());
    for (i = _i = 0, _ref = opts.size - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
      this.items.months().append(this.view.month(opts.init.shift_months(i)));
    }
    // this.items.box().css('width', this.items.box().width() * opts.size);
    this.items.viewport().css('width', this.items.box().width());
    this.items.months().css('width', this.items.months().width() * opts.size);
    this.items.current_month = this.items.first_month();
  };

  function CalendarBehavior(calendar) {
    var month_width,
      _this = this;
    this.calendar = calendar;
    this.items = this.calendar.items;
    this.view = this.calendar.view;
    this.animation_in_progress = false;
    this.animation_speed = 200;
    this.options = this.calendar.options;
    month_width = this.items.month_width();
    this.items.left().click(function() {
      var M, prev_month;
      if (_this.animation_in_progress) {
        return false;
      }
      prev_month = _this.items.current_month.prev().length > 0;
      if (!prev_month) {
        M = new Moment(_this.items.current_month.attr('data-date'));
        M = M.shift_months(-1);
        _this.items.months().prepend(_this.view.month(M));
        _this.items.months().css({
          left: -month_width
        });
      }
      _this.animation_in_progress = true;
      _this.items.months().animate({
        left: "+=" + month_width
      }, _this.animation_speed, function() {
        return _this.animation_in_progress = false;
      });
      return _this.items.current_month = _this.items.current_month.prev();
    });
    this.items.right().click(function() {
      var M, next_month;
      if (_this.animation_in_progress) {
        return false;
      }
      next_month = _this.items.current_month.next().length > (_this.options.size - 1);
      if (!next_month) {
        M = new Moment(_this.items.current_month.attr('data-date'));
        M = M.shift_months(_this.options.size);
        _this.items.months().append(_this.view.month(M));
      }
      _this.animation_in_progress = true;
      _this.items.months().animate({
        left: "-=" + month_width
      }, _this.animation_speed, function() {
        return _this.animation_in_progress = false;
      });
      return _this.items.current_month = _this.items.current_month.next();
    });
  };

  function DayBehavior(calendar) {
    var _this = this;
    var buildTimeList = function(ordered_hash) {
      var M, hash, index, item, key, list, value;
      list = '';
      ordered_hash.sortByKey();
      hash = ordered_hash.get();
      for (index in hash) {
        item = hash[index];
        for (key in item) {
          value = item[key];
          M = new Moment($(value).data('date'));
          list += "<li>" + M.year + " " + (M.month_name()) + " " + M.day + " </li>";
        }
      }    
      return $('.time_list ul').html(list);
    };

    this.calendar = calendar;
    this.items = this.calendar.items;
    this.view = this.calendar.view;
    this.hash = new OrderedHash;
    this.items.days().on('click', function(event) {
      var M, day, obj;
      day = $(event.target);
      M = new Moment(day.data('date'));
      if (!day.hasClass('selected')) {
        obj = {};
        obj[M.unix] = day[0];
        _this.hash.push(obj);
      } else {
        _this.hash.deleteByKey(M.unix);
      }
      day.toggleClass('selected');
      buildTimeList(_this.hash);

      return false;
    });
  };

  var init_time = new Moment(),
      calendar  = new Calendar('#calendar', {
        size: 4,
        locale: DefaultMomentLocale.locale,
        init: init_time,
        border: {
          left: init_time.shift_months(0).shift_days(new Date().getDate()),
          right: init_time.shift_months(0).shift_days()
        }
      });

  new CalendarBehavior(calendar);
  new DayBehavior(calendar);
  
};

$(document).ready(new_ready);
$(document).on('page:load', new_ready);