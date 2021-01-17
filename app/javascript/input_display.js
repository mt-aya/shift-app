if (location.pathname.match(`/boards/${gon.board_id}/shifts`)){
  document.addEventListener("DOMContentLoaded", () => {
    const shiftContents = document.querySelectorAll(".shift-content");
    shiftContents.forEach(function(content) {
      const addShift = content.querySelector(".add-shift");
      const shiftForm = content.querySelector(".shift-create-content");
      const formCancel = shiftForm.querySelector(".shift-create-form-cancel");
      content.addEventListener("mouseover", () => {
        addShift.style.display = "block";
      });
      addShift.addEventListener("click", () => {
        shiftForm.style.display = "block";
      });
      formCancel.addEventListener("click", () => {
        shiftForm.style.display = "none";
      });
      content.addEventListener("mouseleave", () => {
        addShift.style.display = "none";
      });
    });
  });
}