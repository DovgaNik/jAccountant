function validateAndSubmit() {
    let gender = document.getElementById("gender").value;

    if (gender){
        let cells = document.getElementsByTagName("td");
        let foundExisting = false;
        for (let i = 0; i < cells.length; i++){
            if (cells[i].textContent === gender){
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
        output.innerHTML = "❌ Please fill in the field."
    }

}