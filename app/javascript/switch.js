if (location.pathname.match(`/boards/${gon.board_id}/shifts/weekly`)){
  document.addEventListener("DOMContentLoaded", () => {
    const weeklyBtn = document.getElementById("switch-weekly");
    weeklyBtn.style.backgroundColor = "#7dcf8f";
    weeklyBtn.style.fontWeight = "bold";
    weeklyBtn.style.color = "#ffffff"
  });
} else if (location.pathname.match(`/boards/${gon.board_id}/shifts/monthly`)){
  document.addEventListener("DOMContentLoaded", () => {
    const monthlyBtn = document.getElementById("switch-monthly");
    monthlyBtn.style.backgroundColor = "#7dcf8f";
    monthlyBtn.style.fontWeight = "bold";
    monthlyBtn.style.color = "#ffffff"
  });
} else if (location.pathname.match(`/boards/${gon.board_id}/shifts/calendar`)){
  document.addEventListener("DOMContentLoaded", () => {
    const calendarBtn = document.getElementById("switch-calendar");
    calendarBtn.style.backgroundColor = "#7dcf8f";
    calendarBtn.style.fontWeight = "bold";
    calendarBtn.style.color = "#ffffff"
  });
}