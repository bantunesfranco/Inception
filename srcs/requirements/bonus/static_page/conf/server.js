const express = require('express');
const app = express();
const port = 3000;

app.use('/static', express.static('/app/srcs'));

app.listen(port, () => {
    console.log("Server is running on port " + port + "...");
});