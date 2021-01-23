if (typeof gon !== 'undefined') {
  if (location.pathname.match(`/boards/${gon.board_id}/shifts/weekly`)){
    document.addEventListener("DOMContentLoaded", () => {
      const weeklyBtn = document.getElementById("switch-weekly");
      weeklyBtn.style.backgroundColor = "#7dcf8f";
      weeklyBtn.style.fontWeight = "bold";
      weeklyBtn.style.color = "#ffffff";
    });
  } else if (location.pathname.match(`/boards/${gon.board_id}/shifts/monthly`)){
    document.addEventListener("DOMContentLoaded", () => {
      const monthlyBtn = document.getElementById("switch-monthly");
      monthlyBtn.style.backgroundColor = "#7dcf8f";
      monthlyBtn.style.fontWeight = "bold";
      monthlyBtn.style.color = "#ffffff";
    });
  } else if (location.pathname.match(`/boards/${gon.board_id}/shifts/calendar`)){
    document.addEventListener("DOMContentLoaded", () => {
      const calendarBtn = document.getElementById("switch-calendar");
      calendarBtn.style.backgroundColor = "#7dcf8f";
      calendarBtn.style.fontWeight = "bold";
      calendarBtn.style.color = "#ffffff";
    });
  }
}
if (!location.pathname.match("/boards")) {
  document.addEventListener("DOMContentLoaded", () => {
    const requestCalendar = document.getElementById("requested-shift-calendar");
    const fixedCalendar = document.getElementById("fixed-shift-calendar");
    const requestBtnF = document.getElementById("f_r-btn");
    const fixedBtnR = document.getElementById("r_f-btn");
    const requestBtnR = document.getElementById("r_r-btn");
    const fixedBtnF = document.getElementById("f_f-btn");
    fixedBtnF.style.backgroundColor = "#00a1e9";
    fixedBtnF.style.color = "#ffffff";

    requestBtnF.addEventListener('click', () => {
      requestCalendar.style.display = "block";
      fixedCalendar.style.display = "none";
      fixedBtnR.removeAttribute("style");
      requestBtnR.style.backgroundColor = "#00a1e9";
      requestBtnR.style.color = "#ffffff";
    });
    fixedBtnR.addEventListener('click', () => {
      console.log(2);
      requestCalendar.style.display = "none";
      fixedCalendar.style.display = "block";
      requestBtnF.removeAttribute("style");
      fixedBtnF.style.backgroundColor = "#00a1e9";
      fixedBtnF.style.color = "#ffffff";
    });
  });
}