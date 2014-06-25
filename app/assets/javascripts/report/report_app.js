function launchReportApp(auth) {
	if (typeof auth === "string") {
  	auth = { headers: {"Authorization":auth}};
  }

  createReport(); 
  


}