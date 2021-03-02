if (location.pathname.match(`/boards/${gon.board_id}/shifts`)){
  document.addEventListener("DOMContentLoaded", () => {
    // 日ごと
    const modalOverlay = document.getElementById("board-show-modal");
    const shiftContents = document.querySelectorAll(".shift-content__top");
    shiftContents.forEach(function(content) {
      const shiftForm = content.querySelector(".shift-create-content");
      const formCancel = shiftForm.querySelector(".shift-create-form-cancel");
      content.addEventListener("click", (e) => {
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
        if(shift.dataset.decided === "true"){
          // 共有されているシフトの場合、シフト時間の背景色、文字色が変わる
          const shiftTime = shift.querySelector(".shift-time");
          const shiftMenuIcon = shift.querySelector(".shift-menu-icon");
          const shiftOneContent = shift.querySelector(".one-shift-time");
          shiftOneContent.style.backgroundColor = "rgba(60,179,122,0.9)";
          shiftTime.style.color = "#ffffff";
          shiftMenuIcon.style.display = "none";
        } else {
          // 共有されていないシフトの場合、シフトの編集ができる
          shiftEditBtn.addEventListener("click", () => {
            modalOverlay.style.display = "block";
            shiftEditForm.style.display = "block";
          });
          editCancel.addEventListener("click", () => {
            shiftEditForm.style.display = "none";
            modalOverlay.style.display = "none";
          });
        }
      });
    });
  });
}