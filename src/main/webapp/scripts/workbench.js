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