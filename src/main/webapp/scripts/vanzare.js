function validateAndSubmit() {
    let date = document.getElementById("date").value;
    let seller = document.getElementById("seller").value;
    let product = document.getElementById("product").value;
    let caen = document.getElementById("caen").value;
    let quantity = document.getElementById("quantity").value;
    let um = document.getElementById("um").value;
    let cheltuieli = document.getElementById("cheltuieli").value;
    let venituri = document.getElementById("venituri").value;
    let note = document.getElementById("note").value;
    let deductibil = document.getElementById("deductibil").value;
    let profit = document.getElementById("profit").value;
    let impozabil = document.getElementById("impozabil").value;
    let impozit = document.getElementById("impozit").value;

    console.log(date);
    console.log(seller);
    console.log(product);
    console.log(caen);
    console.log(quantity);
    console.log(um);
    console.log(cheltuieli);
    console.log(venituri);
    console.log(note);
    console.log(deductibil);
    console.log(profit);
    console.log(impozabil);
    console.log(impozit);

    if (date && seller && product && quantity && um) {
        document.add_form.submit();
    } else {
        let output = document.getElementById("output");
        output.innerHTML = "❌ Please fill in all required fields."
    }

}