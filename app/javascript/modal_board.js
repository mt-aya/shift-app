if (location.pathname.match(`/boards/${gon.board_id}`)){
  document.addEventListener("DOMContentLoaded", () => {
    const boardNameBtn = document.getElementById("board-name-btn");

    // 表示されているシフトボード名クリックした場合の処理
    boardNameBtn.addEventListener("click", () => {
      const modalOverlay = document.getElementById("board-show-modal");
      modalOverlay.style.display = 'block';
      const closeBtn = document.getElementById("modal-close-btn");
      // シフトボード名編集画面（モーダルウィンドウ）の閉じるボタンをクリックした場合の処理
      closeBtn.addEventListener("click", () => {
        modalOverlay.style.display = 'none';
      });
      const submit = document.getElementById("edit-submit-btn");
      // 「変更する」をクリックした場合の処理
      submit.addEventListener("click", (e) => {
        const editData = new FormData(document.getElementById("edit-form"));
        const XHR = new XMLHttpRequest();
        XHR.open("PATCH", `/boards/${gon.board_id}`, true);
        XHR.responseType = 'json';
        XHR.send(editData);
        // レスポンスを受け取った場合の処理
        XHR.onload = () => {
          if (XHR.status != 200) {
            alert(`Error ${XHR.status}: ${XHR.statusText}`);
            return null;
          }
          const responseBoard = XHR.response.board;
          boardNameBtn.innerHTML = responseBoard.name;  // シフトボード名の表示の変更
          modalOverlay.style.display = 'none';          // モーダルウィンドウを閉じる
        };
        e.preventDefault();
      });
    });
  });
}