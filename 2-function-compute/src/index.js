exports.handler = function(request, response, context) {
  response.setStatusCode(200);
  response.setHeader("Content-Type", "application/json");
  response.setHeader("Content-Disposition", "inline");
  return response.send(
    JSON.stringify({
      status: "works 2!"
    })
  );
};
