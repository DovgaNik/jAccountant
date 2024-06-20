function validateAndSubmit() {
	let name = document.getElementById("name");
	let description = document.getElementById("description");
	let category = document.getElementById("category");
	if (name.value && description.value && category.value) {
		document.add_form.submit();
	} else {
		document.getElementById("output").innerHTML = "❌ Please check that you have entered all the required fields!"
	}
}