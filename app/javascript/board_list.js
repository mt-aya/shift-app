if (location.pathname.match(`/boards/${gon.board_id}/shifts`)) {
  document.addEventListener("DOMContentLoaded", () => {
    const boardListMenuBtn = document.getElementById("board-list-menu");
    const boardListPulldown = document.getElementById("board-list-pulldown");

    boardListMenuBtn.addEventListener('click', () => {
      if (boardListPulldown.style.display == "none") {
        boardListPulldown.style.display = "block";
      } else {
        boardListPulldown.style.display = "none";
      }
    });
  });
}