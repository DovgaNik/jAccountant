function validateAndSubmit() {
	let gender = document.getElementById("gender");
	if (gender.value) {
		document.add_form.submit();
	} else {
		document.getElementById("output").innerHTML = "❌ Please check that you have entered all the required fields!"
	}
}