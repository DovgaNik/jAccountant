function validateAndSubmit() {
    let um = document.getElementById("um").value;
    let ab_um = document.getElementById("ab_um").value;

    if (um && ab_um){
        let cells = document.getElementsByTagName("td");
        let foundExisting = false;
        for (let i = 0; i < cells.length; i++){
            if (cells[i].textContent === um || cells[i].textContent === ab_um){
                foundExisting = true;
            }
        }
        if (!foundExisting){
            document.add_form.submit();
        } else {
            let output = document.getElementById("output");
            output.innerHTML = "❌ You have provided a measure unit that already exists in the database."
        }
    } else {
        let output = document.getElementById("output");
        output.innerHTML = "❌ Please fill in both fields."
    }

}