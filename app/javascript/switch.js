if (location.pathname.match(`/boards/${gon.board_id}/shifts`)) {
  document.addEventListener("DOMContentLoaded", () => {
    const monthBtn = document.getElementById("switch-month");
    const weekBtn = document.getElementById("switch-week");
    const calendarBtn = document.getElementById("switch-calendar");

    const monthShift = document.getElementById("month-shift");
    const weekShift = document.getElementById("week-shift");
    const monthCalendar = document.getElementById("month-calendar");

    monthBtn.addEventListener('click', () => {
      if (monthShift.style.display == "none") {
        monthCalendar.style.display = "none";
        weekShift.style.display = "none";
        monthShift.style.display = "block";
      }
    });
    weekBtn.addEventListener('click', () => {
      if (weekShift.style.display == "none") {
        monthCalendar.style.display = "none";
        monthShift.style.display = "none";
        weekShift.style.display = "block";
      }
    });
    calendarBtn.addEventListener('click', () => {
      if (monthCalendar.style.display == "none") {
        monthShift.style.display = "none";
        weekShift.style.display = "none";
        monthCalendar.style.display = "block";
      }
    });
  });
}