if (location.pathname.match(`/boards/${gon.board_id}/shifts`)){
  document.addEventListener("DOMContentLoaded", () => {
    // 日ごと
    const modalOverlay = document.getElementById("board-show-modal");
    const shiftContents = document.querySelectorAll(".shift-content");
    shiftContents.forEach(function(content) {
      const shiftForm = content.querySelector(".shift-create-content");
      const formCancel = shiftForm.querySelector(".shift-create-form-cancel");
      content.addEventListener("dblclick", (e) => {
        if(!e.target.closest(".shift-content-exist")){
          modalOverlay.style.display = "block";
          shiftForm.style.display = "block";
        }
      });
      formCancel.addEventListener("click", () => {
        shiftForm.style.display = "none";
        modalOverlay.style.display = "none";
      });

      // シフトごと
      const shiftTimes = content.querySelectorAll(".each-shift-time-content");
      shiftTimes.forEach(function(shift) {
        const shiftEditBtn = shift.querySelector(".shift-menu-edit");
        const shiftEditForm = shift.querySelector(".shift-edit-content");
        const editCancel = shiftEditForm.querySelector(".shift-edit-form-cancel");
        shiftEditBtn.addEventListener("click", () => {
          modalOverlay.style.display = "block";
          shiftEditForm.style.display = "block";
        });
        editCancel.addEventListener("click", () => {
          shiftEditForm.style.display = "none";
          modalOverlay.style.display = "none";
        });
      });
    });
  });
}