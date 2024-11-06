$(function(){
  const imageInput = document.getElementById('imageInput');
  const imagePreviewDiv = document.getElementById('new-image');
  const analyzeButton = document.getElementById('analyzeImageButton');
  const analyzeIntroductionButton = document.getElementById('analyzeIntroductionButton')

  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  const createImageHTML = (blob) => {
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-img img-fluid mt-2');
    blobImage.setAttribute('src', blob);
    imagePreviewDiv.appendChild(blobImage);
  };

  const selectTagsBasedOnAnalysis = (tagIds) => {
    tagIds.forEach(tagId => {
      const checkbox = document.querySelector(`input[type="checkbox"][value="${tagId}"]`);
      if (checkbox) {
        checkbox.checked = true;
      }
    });
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

    // 画像分析ボタンのイベントリスナーを追加
    analyzeButton.addEventListener('click', () => {
      const files = imageInput.files;

      if (files.length === 0) {
        alert('画像を選択してください。');
        return;
      }

      const formData = new FormData();
      for (let i = 0; i < files.length; i++) {
        formData.append('post[images][]', files[i]);
      }

      // 画像認証APIを呼び出す
      fetch('/posts/process_image_analysis', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': csrfToken
        },
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        // 取得したタグIDで自動的にチェックボックスを選択
        selectTagsBasedOnAnalysis(data.tag_ids); // タグIDを使用して選択
      })
      .catch(error => {
        console.error('エラー:', error);
      });
    });

    analyzeIntroductionButton.addEventListener('click', () => {
      const introductionText = post_introduction.value;

      if (introductionText.trim() === '') {
        alert('紹介文を入力してください。');
        return;
      }

      const formData = new FormData();
      formData.append('post[introduction]', introductionText);

      fetch('/posts/process_introduction_analysis', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': csrfToken
        },
        body: formData
      })

      .then(response => response.json())
      .then(data => {
        selectTagsBasedOnAnalysis(data.tag_ids);
      })
      .catch(error => {
        console.error('エラー:', error);
      });
    });
  }
});