$(function(){
  const imageInput = document.getElementById('imageInput');
  const imagePreviewDiv = document.getElementById('new-image');

  const createImageHTML = (blob) => {
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-img img-fluid mt-2');
    blobImage.setAttribute('src', blob);
    imagePreviewDiv.appendChild(blobImage);
  };

  if (document.URL.match(/new/) || document.URL.match(/edit/)) {
    imageInput.addEventListener('change', (e) => {
      const files = e.target.files;

      // 既存の内容をクリアするのはファイルが変更された場合のみ
      imagePreviewDiv.innerHTML = '';

      // すべてのファイルに対してループ処理
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        if (file) {
          const blob = window.URL.createObjectURL(file);
          createImageHTML(blob);
        }
      }

      if (files.length === 0) {
        // 新しいファイルが選択されなかった場合、既存の内容を表示
        imagePreviewDiv.innerHTML = '<p>ファイルが選択されていません</p>';
      }
    });
  }
});