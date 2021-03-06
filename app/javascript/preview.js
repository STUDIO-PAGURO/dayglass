if (document.URL.match( /new/ ) || document.URL.match( /edit/)) {
  document.addEventListener('DOMContentLoaded', function(){
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');

      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.classList.add('preview-size');
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };

    document.getElementById('post_image').addEventListener('change', function(e){
      const imageContent = document.querySelector('#image-list > img');
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}