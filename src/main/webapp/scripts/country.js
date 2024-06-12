function validateAndSubmit() {
    let country = document.getElementById("country").value;
    let ab_country = document.getElementById("codeOfCountry").value;

    if (country && ab_country){
        let cells = document.getElementsByTagName("td");
        let foundExisting = false;
        for (let i = 0; i < cells.length; i++){
            if (cells[i].textContent === country || cells[i].textContent === ab_country){
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