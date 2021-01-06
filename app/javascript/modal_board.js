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
      const editSubmit = document.getElementById("edit-submit-btn");
      // 「変更する」をクリックした場合の処理
      editSubmit.addEventListener("click", (e) => {
        const editData = new FormData(document.getElementById("edit-form"));
        const updateXhr = new XMLHttpRequest();
        updateXhr.open("PATCH", `/boards/${gon.board_id}`, true);
        updateXhr.responseType = 'json';
        updateXhr.send(editData);
        // レスポンスを受け取った場合の処理
        updateXhr.onload = () => {
          if (updateXhr.status != 200) {
            alert(`Error ${updateXhr.status}: ${updateXhr.statusText}`);
            return null;
          }
          const responseBoard = updateXhr.response.board;
          const boardNameText = document.getElementById("board-name-text");
          boardNameText.innerHTML = responseBoard.name;  // シフトボード名の表示の変更
          modalOverlay.style.display = 'none';          // モーダルウィンドウを閉じる
          modalEditWindow.style.display = 'none';
        };
        e.preventDefault();
      });
    });

    // 招待ボタンをクリックした場合の処理
    inviteBtn.addEventListener("click", () => {
      const emptyHtml = function() {
        lastName.innerHTML = "";
        firstName.innerHTML = "";
        noStaff.innerHTML = "";
      }
      const modalInviteWindow = document.getElementById("board-invite-content");
      const lastName = document.getElementById("invite_staff_last_name");
      const firstName = document.getElementById("invite_staff_first_name");
      const noStaff = document.getElementById("result-no-staff");
      const inviteSubmit = document.getElementById("invite-staff-submit");
      modalOverlay.style.display = 'block';
      modalInviteWindow.style.display = 'block';
      const inviteCloseBtn = document.getElementById("invite-close-btn");
      // 招待画面（モーダルウィンドウ）の閉じるボタンをクリックした場合の処理
      inviteCloseBtn.addEventListener("click", () => {
        emptyHtml();
        modalOverlay.style.display = 'none';
        modalInviteWindow.style.display = 'none';
        inviteSubmit.style.display = "none";
        document.getElementById('invite-staff-name').value = '';
      });
      const searchSubmit = document.getElementById("search-staff-btn");
      // 招待画面（モーダルウィンドウ）の「検索する」ボタンをクリックした場合の処理
      searchSubmit.addEventListener("click", () => {
        emptyHtml();
        const keyword = document.getElementById("invite-staff-name").value;
        const searchXhr = new XMLHttpRequest();
        searchXhr.open("GET", `/boards/${gon.board_id}/search/?keyword=${keyword}`, true);
        searchXhr.responseType = 'json';
        searchXhr.send();
        searchXhr.onload = () => {
          if (searchXhr.status != 200) {
            alert(`Error ${searchXhr.status}: ${searchXhr.statusText}`);
            return null;
          }
          const responseSearch = searchXhr.response.results;
          const objResult = Object.values(responseSearch);
          if (objResult.length != 0){
            objResult.forEach(function(list){
              lastName.innerHTML = list.last_name;
              firstName.innerHTML = list.first_name;
              inviteSubmit.style.display = "block";
            })
          } else {
            inviteSubmit.style.display = "none";
            const noStaff = document.getElementById("result-no-staff");
            noStaff.innerHTML = "一致するユーザーは存在しません。";
          }
        };
      });
    })
  });
}