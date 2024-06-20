function validateAndSubmit() {
	let gender = document.getElementById("type");
	if (gender.value) {
		document.add_form.submit();
	} else {
		document.getElementById("output").innerHTML = "❌ Please check that you have entered all the required fields!"
	}
}