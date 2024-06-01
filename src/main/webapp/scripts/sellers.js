function validateAndSubmit() {
    let seller = document.getElementById("seller").value;
    let uniqueCode = document.getElementById("uniqueCode").value;

    if (seller && uniqueCode){
        let cells = document.getElementsByTagName("td");
        let foundExisting = false;
        for (let i = 0; i < cells.length; i++){
            if (cells[i].textContent === seller || cells[i].textContent === uniqueCode){
                foundExisting = true;
            }
        }
        if (!foundExisting){
            document.add_form.submit();
        } else {
            let output = document.getElementById("output");
            output.innerHTML = "❌ You have provided a seller that already exists in the database."
        }
    } else {
        let output = document.getElementById("output");
        output.innerHTML = "❌ Please fill in both fields."
    }

}