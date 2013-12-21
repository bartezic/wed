window.WedCity = window.WedCity || {};

var locale = {
  en: {
    'month': {
      'name': ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      'abbr': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      'abbr2': ['Jan.', 'Feb.', 'Mar.', 'Apr.', 'May.', 'Jun.', 'Jul.', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.']
    },
    'day': {
      'name': ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
      'abbr': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      'part': {
        'night': 'night',
        'morning': 'morning',
        'day': 'day',
        'evening': 'evening'
      }
    }
  },
  uk: {
    'month': {
      'name': ['Січень', 'Лютий', 'Березень', 'Квітень', 'Травень', 'Червень', 'Липень', 'Серпень', 'Вересень', 'Жовтень', 'Листопад', 'Грудень'],
      'abbr': ['Січ', 'Лют', 'Бер', 'Квіт', 'Трав', 'Черв', 'Лип', 'Серп', 'Вер', 'Жовт', 'Лист', 'Груд'],
      'abbr2': ['Січ.', 'Лют.', 'Бер.', 'Квіт.', 'Трав.', 'Черв.', 'Лип.', 'Серп.', 'Вер.', 'Жовт.', 'Лист.', 'Груд.'],
    },
    'day': {
      'name': ['Понеділок', 'Вівторок', 'Середа', 'Четвер', "П'ятниця", 'Субота', 'Неділя'],
      'abbr': ['Пн.', 'Вт.', 'Ср.', 'Чт.', "Пт.", 'Сб.', 'Нд.'],
      'part': {
        'night': 'night',
        'morning': 'morning',
        'day': 'day',
        'evening': 'evening'
      }
    }
  }
};

window.WedCity.l = locale['uk']