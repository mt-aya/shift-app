if (location.pathname.match(`/boards/${gon.board_id}/shifts`)){
  document.addEventListener("DOMContentLoaded", () => {
    const boardNameBtn = document.getElementById("board-name-btn");
    const inviteBtn = document.getElementById("invite-btn");
    const modalOverlay = document.getElementById("board-show-modal");
    const modalEditWindow = document.getElementById("board-edit-content");
    const editSubmit = document.getElementById("edit-submit-btn");

    // 表示されているシフトボード名クリックした場合の処理
    boardNameBtn.addEventListener("click", () => {
      modalOverlay.style.display = 'block';
      modalEditWindow.style.display = 'block';
      const editCloseBtn = document.getElementById("edit-close-btn");
      // シフトボード名編集画面（モーダルウィンドウ）の閉じるボタンをクリックした場合の処理
      editCloseBtn.addEventListener("click", () => {
        modalOverlay.style.display = 'none';
        modalEditWindow.style.display = 'none';
      });
    });
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
        const pulldownLink = document.getElementById("pulldown-board-link")
        boardNameText.innerHTML = responseBoard.name;  // シフトボード名の表示の変更
        pulldownLink.innerHTML = responseBoard.name;
        modalOverlay.style.display = 'none';           // モーダルウィンドウを閉じる
        modalEditWindow.style.display = 'none';
      };
      e.preventDefault();
    });


    const staffName = document.getElementById("result-staff-name");
    const resultMessage = document.getElementById("result-message");
    const modalInviteWindow = document.getElementById("board-invite-content");
    const inviteSubmit = document.getElementById("invite-staff-submit");
    const searchSubmit = document.getElementById("search-staff-btn");
    const emptyHtml = function() {
      staffName.innerHTML = "";
      resultMessage.innerHTML = "";
    }
    // 招待ボタンをクリックした場合の処理
    inviteBtn.addEventListener("click", () => {
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
    });

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
        if (objResult.length == 0) {
          inviteSubmit.style.display = "none";
          return resultMessage.innerHTML = "一致するユーザーは存在しません。";
        } else {
          objResult.forEach(function(list){
            if (gon.board_staffs_id.includes(list.id)) {
              return resultMessage.innerHTML = "既に現在のボードに追加済みのユーザーです。";
            } else {
              staffName.innerHTML = `${list.last_name} ${list.first_name}`;
              inviteSubmit.style.display = "block";
            }
          })
        }
      };
    });
    // 招待画面（モーダルウィンドウ）の検索後に「招待」ボタンをクリックした場合の処理
    inviteSubmit.addEventListener("click", (e) => {
      const inviteData = new FormData(document.getElementById("invite-form"));
      const inviteXhr = new XMLHttpRequest();
      inviteXhr.open("POST", `/boards/${gon.board_id}/invite`, true);
      inviteXhr.responseType = 'json';
      inviteXhr.send(inviteData);
      inviteXhr.onload = () => {
        if (inviteXhr.status != 200) {
          alert(`Error ${inviteXhr.status}: ${inviteXhr.statusText}`);
          return null;
        }
        const addStaff = document.getElementById("add-staff");
        const responseInvite = inviteXhr.response.result;
        const addStaffHtml = `
          <div class="member-list">
            <a href="#">${responseInvite.last_name}</a>
          </div>`
        addStaff.insertAdjacentHTML("afterend", addStaffHtml);
        emptyHtml();
        document.getElementById('invite-staff-name').value = '';
        inviteSubmit.style.display = "none";
        };
      e.preventDefault();
    });
  });
}