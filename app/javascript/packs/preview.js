document.addEventListener('turbolinks:load', () => {
  const imageInput = document.getElementById('imageInput');
  const imagePreviewDiv = document.getElementById('new-image');

  const createImageHTML = (blob) => {
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-img img-fluid mt-2');
    blobImage.setAttribute('src', blob);
    imagePreviewDiv.appendChild(blobImage);
  };

  if (document.URL.match(/new/)) {
    imageInput.addEventListener('change', (e) => {
      imagePreviewDiv.innerHTML = '';

      const file = e.target.files[0];
      if (file) {
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      } else {
        // 新しいファイルが選択されなかった場合、既存の内容を表示
        imagePreviewDiv.innerHTML = '<p>ファイルが選択されていません</p>';
      }
    });

  } else if (document.URL.match(/edit/)) {
    imageInput.addEventListener('change', (e) => {
      imagePreviewDiv.innerHTML = '';

      const file = e.target.files[0];
      if (file) {
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      }
    });
  }
});