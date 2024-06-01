function validateAndSubmit() {
    let product = document.getElementById("product").value;

    if (product){
        let cells = document.getElementsByTagName("td");
        let foundExisting = false;
        for (let i = 0; i < cells.length; i++){
            if (cells[i].textContent === product){
                foundExisting = true;
            }
        }
        if (!foundExisting){
            document.add_form.submit();
        } else {
            let output = document.getElementById("output");
            output.innerHTML = "❌ You have provided a product that already exists in the database."
        }
    } else {
        let output = document.getElementById("output");
        output.innerHTML = "❌ Please fill in the field."
    }

}