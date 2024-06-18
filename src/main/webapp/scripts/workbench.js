function switchType(control) {
	let entityLabel = document.getElementById("entity_label");
	let entityContainer = document.getElementById("entity_container");

	if (control.id == "business"){
		entityLabel.innerHTML = "Furnizor:";
		entityContainer.style.display = "";
	} else {
		entityLabel.innerHTML = "Persoana:";
		entityContainer.style.display = "";
	}
}