exports.handler = (event, context, callback) => {
  const responseBody = {
    "hello": "world",
    "context": context,
    "event": JSON.parse(event)
  }

  const response = {
    isBase64Encoded: false,
    statusCode: 200,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(responseBody)
  }

  callback(null, response)
}