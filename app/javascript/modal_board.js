if (location.pathname.match(`boards/${gon.board_id}`)){
  document.addEventListener("DOMContentLoaded", () => {
    const boardNameBtn = document.getElementById("board-name-btn");
    boardNameBtn.addEventListener("click", () => {
      const modalOverlay = document.getElementById("board-show-modal");
      modalOverlay.style.display = 'block';
      const closeBtn = document.getElementById("modal-close-btn");
      closeBtn.addEventListener("click", () => {
        modalOverlay.style.display = 'none';
      });
    });
  });
}