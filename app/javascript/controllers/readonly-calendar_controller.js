import Rails from '@rails/ujs';
import 'tui-time-picker/dist/tui-time-picker.css';
import 'tui-calendar/dist/tui-calendar.css';
import Calendar from 'tui-calendar';
import { Controller } from 'stimulus';
import dateFormat from 'dateformat';

export default class extends Controller {
  static targets = [
    'month',
    'monthActive',
    'week',
    'weekActive',
    'day',
    'dayActive',
    'header',
  ];

  connect() {
    console.log('Hello from readonly-calendar_controller.js');

    this.monthTarget.style.display = 'none';
    this.weekActiveTarget.style.display = 'none';
    this.dayActiveTarget.style.display = 'none';

    this.calendar = new Calendar(document.getElementById('calendar'), {
      id: '1',
      name: 'My Calendar',
      defaultView: 'month',
      color: '#00a9ff',
      bgColor: '#00a9ff',
      dragBgColor: '#00a9ff',
      borderColor: 'red',
      isReadOnly: true,
      taskView: false,

      milestone: false, // Can be also ['milestone', 'task']
      scheduleView: true, // Can be also ['allday', 'time']
      useCreationPopup: true,
      useDetailPopup: true,
      template: {
        milestone: function (schedule) {
          return (
            '<span style="color:red;"><i class="fa fa-flag"></i> ' +
            schedule.title +
            '</span>'
          );
        },

        monthDayname: function (dayname) {
          return (
            '<span class="calendar-week-dayname-name">' + dayname.label + '</span>'
          );
        },

        allday: function (schedule) {
          return schedule.title + ' <i class="fa fa-refresh"></i>';
        },

        alldayTitle: function () {
          return 'All Day';
        },

        time: function (schedule) {
          return schedule.title + ' <i class="fa fa-refresh"></i>' + schedule.start;
        },
      },
      month: {
        daynames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        startDayOfWeek: 0,
        narrowWeekend: true,
      },
      week: {
        daynames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        startDayOfWeek: 0,
        narrowWeekend: true,
      },
    });

    this.syncData();
    this.syncDate();
  }

  syncData() {
    this.getCalendardata();
  }

  syncDate() {
    switch (this.calendar.getViewName()) {
      case 'week':
        this.headerTarget.textContent = `${dateFormat(
          this.calendar.getDateRangeStart(),
          'mediumDate',
        )} - ${dateFormat(this.calendar.getDateRangeEnd(), 'mediumDate')}`;
        break;

      case 'month':
        this.headerTarget.textContent = dateFormat(
          this.calendar.getDate(),
          'mmmm yyyy',
        );
        break;
      default:
        this.headerTarget.textContent = dateFormat(
          this.calendar.getDate(),
          'mediumDate',
        );
        break;
    }
  }

  setWeekView(event) {
    event.preventDefault();
    this.calendar.changeView('week', true);

    this.weekActiveTarget.style.display = 'inline-block';
    this.weekTarget.style.display = 'none';

    this.monthTarget.style.display = 'inline-block';
    this.monthActiveTarget.style.display = 'none';

    this.dayTarget.style.display = 'inline-block';
    this.dayActiveTarget.style.display = 'none';

    this.syncDate();
  }

  setMonthView(event) {
    event.preventDefault();
    this.calendar.changeView('month', true);
    this.calendar.setOptions({ month: { narrowWeekend: true } }, true);

    this.monthActiveTarget.style.display = 'inline-block';
    this.monthTarget.style.display = 'none';

    this.weekTarget.style.display = 'inline-block';
    this.weekActiveTarget.style.display = 'none';

    this.dayTarget.style.display = 'inline-block';
    this.dayActiveTarget.style.display = 'none';

    this.syncDate();
  }

  setDayView(event) {
    event.preventDefault();
    this.calendar.changeView('day', true);

    this.dayActiveTarget.style.display = 'inline-block';
    this.dayTarget.style.display = 'none';

    this.weekTarget.style.display = 'inline-block';
    this.weekActiveTarget.style.display = 'none';

    this.monthTarget.style.display = 'inline-block';
    this.monthActiveTarget.style.display = 'none';

    this.syncDate();
  }

  today(event) {
    event.preventDefault();
    this.calendar.today();
    this.syncDate();
  }

  prev(event) {
    event.preventDefault();
    this.calendar.prev();
    this.syncDate();
  }

  next(event) {
    event.preventDefault();
    this.calendar.next();
    this.syncDate();
  }

  getCalendardata() {
    var schedules = JSON.parse(
      document.querySelector('#calendar').dataset.schedules,
    );
    console.log('SCHEDULES');
    console.log(schedules);
    window.schedules = schedules;
    schedules.forEach((schedule) => {
      this.calendar.createSchedules([
        {
          id: schedule.id,
          calendarId: schedule.calendar_id,
          title: schedule.title,
          category: 'time',
          dueDateClass: schedule.dueDateClass,
          location: schedule.location,
          start: schedule.start,
          end: schedule.end,
        },
      ]);
    });
  }
}
