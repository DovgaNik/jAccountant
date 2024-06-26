function switchType(control) {
	let supplierContainer = document.getElementById("customer_container");
	let customerContainer = document.getElementById("supplier_container");

	if (control.id === "business_radio"){
		customerContainer.style.display = "";
		supplierContainer.style.display = "none";
	} else {
		supplierContainer.style.display = "";
		customerContainer.style.display = "none";
	}
}

function validateAndSubmit(){
	let type_customer = document.getElementById("customer_radio");
	let type_supplier = document.getElementById("business_radio");
	let date = document.getElementById("date");
	let supplier = document.getElementById("supplier");
	let person = document.getElementById("customer");

	if ((type_customer.checked || type_supplier.checked) && date.value && (supplier.value || person.value)) {
		document.add_form.submit();
	} else {
		document.getElementById("output").innerHTML = "❌ Please check that you have entered all the required fields!"
	}

}

function submitTransaction() {
	let factura = document.getElementById("invoice");
	let product = document.getElementById("product");
	let caen = document.getElementById("caen");
	let cantitate = document.getElementById("quantity");
	let unit_of_measure = document.getElementById("um");
	let spendings = document.getElementById("cheltuieli");
	let incomings = document.getElementById("venituri");

	if (factura.value && product.value && caen.value && cantitate.value && unit_of_measure.value && (spendings.value || incomings.value)) {
		document.add_transaction.submit();
	} else {
		document.getElementById("output_transaction").innerHTML = "❌ Please check that you have entered all the required fields!"
	}
}
