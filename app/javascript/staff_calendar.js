if (!location.pathname.match("/boards")) {
  document.addEventListener("DOMContentLoaded", () => {
    // 確定シフト・希望シフト切り替え ここから
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
      requestCalendar.style.display = "none";
      fixedCalendar.style.display = "block";
      requestBtnF.removeAttribute("style");
      fixedBtnF.style.backgroundColor = "#00a1e9";
      fixedBtnF.style.color = "#ffffff";
    });
    // 確定シフト・希望シフト切り替え ここまで

    // シフト追加ページを開く・閉じる ここから
    const dayCalendar = requestCalendar.querySelectorAll(".staff-date-content");
    dayCalendar.forEach(function(day) {
      const requestAddShift = day.querySelector(".shift-request-add");
      const staffOverlay = document.getElementById("staff-modal-overlay");
      const cancelRequestAdd = requestAddShift.querySelector(".staff-add-shift-cancel");
      day.addEventListener('click', (e) => {
        if(!e.target.closest(".except-month-day")) {
          staffOverlay.style.display = "block";
          requestAddShift.style.display = "block";
        }
      });
      cancelRequestAdd.addEventListener('click', () => {
        staffOverlay.style.display = "none";
        requestAddShift.style.display = "none";
      });
    });
    // シフト追加ページを開く・閉じる ここまで
  });
}