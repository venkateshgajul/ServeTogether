document.querySelectorAll('.read-more').forEach(button => {
    button.addEventListener('click', () => {
        const moreContent = button.previousElementSibling;
        if (moreContent.style.display === 'none' || !moreContent.style.display) {
            moreContent.style.display = 'block';
            button.textContent = 'Read Less';
        } else {
            moreContent.style.display = 'none';
            button.textContent = 'Read More';
        }
    });
});
