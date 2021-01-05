if (location.pathname.match(`/boards/${gon.board_id}`)){
  document.addEventListener("DOMContentLoaded", () => {
    const boardNameBtn = document.getElementById("board-name-btn");
    const inviteBtn = document.getElementById("invite-btn");
    const modalOverlay = document.getElementById("board-show-modal");

    // 表示されているシフトボード名クリックした場合の処理
    boardNameBtn.addEventListener("click", () => {
      const modalEditWindow = document.getElementById("board-edit-content");
      modalOverlay.style.display = 'block';
      modalEditWindow.style.display = 'block';
      const editCloseBtn = document.getElementById("edit-close-btn");
      // シフトボード名編集画面（モーダルウィンドウ）の閉じるボタンをクリックした場合の処理
      editCloseBtn.addEventListener("click", () => {
        modalOverlay.style.display = 'none';
        modalEditWindow.style.display = 'none';
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

    // 招待ボタンをクリックした場合の処理
    inviteBtn.addEventListener("click", () => {
      const modalInviteWindow = document.getElementById("board-invite-content");
      modalOverlay.style.display = 'block';
      modalInviteWindow.style.display = 'block';
      const inviteCloseBtn = document.getElementById("invite-close-btn");
      // 招待画面（モーダルウィンドウ）の閉じるボタンをクリックした場合の処理
      inviteCloseBtn.addEventListener("click", () => {
        modalOverlay.style.display = 'none';
        modalInviteWindow.style.display = 'none';
      });
    })
  });
}