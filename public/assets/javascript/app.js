document.addEventListener("DOMContentLoaded", function() {
    const buttons = document.querySelectorAll("[data-text_select_id]");
    buttons.forEach((button) => {
        button.addEventListener("click", function() {
            const textInputId = this.dataset.text_select_id;
            const inputElement = document.querySelector(`[data-text_input_id="${textInputId}"]`);
            inputElement.select();
        });
    });
});