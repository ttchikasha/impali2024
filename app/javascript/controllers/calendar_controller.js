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
    console.log('Hello from calendar_controller.js');

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
    this.deleteCalendarSchedule();
    this.updatedCalendarSchedule();
    this.getCalendardata();
    this.createCalendarSchedule();
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

  createCalendarSchedule() {
    let calendar = this.calendar;
    calendar.on('beforeCreateSchedule', function (event) {
      var triggerEventName = event.triggerEventName;
      var schedule = {
        // id: 1,
        calendarId: '1',
        title: event.title,
        category: 'time',
        location: event.location,
        start: event.start,
        end: event.end,
      };
      if (triggerEventName === 'click') {
        // open writing simple schedule popup
        // schedule = {...};
      } else if (triggerEventName === 'dblclick') {
        // open writing detail schedule popup
        // schedule = {...};
      }

      calendar.createSchedules([schedule]);
      let formData = new FormData();
      formData.append('title', schedule.title);
      formData.append('category', schedule.category);
      formData.append('start', schedule.start._date);
      formData.append('end', schedule.end._date);
      formData.append('location', schedule.location);

      Rails.ajax({
        type: 'POST',
        url: '/schedules',
        data: formData,
      });
    });
  }

  updatedCalendarSchedule() {
    let calendar = this.calendar;
    calendar.on('beforeUpdateSchedule', function (event) {
      var schedule = event.schedule;
      var changes = event.changes;
      var formUpdate = new FormData();
      if (changes.end) {
        formUpdate.append('end', changes.end._date);
      }
      if (changes.start) {
        formUpdate.append('start', changes.start._date);
      }
      if (changes.title) {
        formUpdate.append('title', changes.title);
      }
      if (changes.category) {
        formUpdate.append('category', changes.category);
      }
      calendar.updateSchedule(schedule.id, schedule.calendarId, changes);

      Rails.ajax({
        type: 'PATCH',
        url: '/schedules/' + schedule.id,
        data: formUpdate,
      });
    });
  }

  deleteCalendarSchedule() {
    let calendar = this.calendar;
    calendar.on('beforeDeleteSchedule', function (event) {
      var schedule = event.schedule;
      calendar.deleteSchedule(schedule.id, schedule.calendarId);

      Rails.ajax({
        type: 'DELETE',
        url: '/schedules/' + schedule.id,
      });
    });
  }
}
