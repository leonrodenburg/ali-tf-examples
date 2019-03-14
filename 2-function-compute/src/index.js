exports.handler = function(request, response, context) {
  response.setStatusCode(200);
  response.setHeader("Content-Type", "application/json");

  return response.send(
    JSON.stringify({
      status: "It works!"
    })
  );
};
