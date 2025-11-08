const express = require('express')
const app = express()
const PORT = process.env.PORT || 8080

app.get('/', (req, res) => {
  res.json({ message: 'Hello from frontend!', backend: process.env.BACKEND_URL || 'unset' })
})

app.listen(PORT, () => console.log(`Frontend listening on ${PORT}`))
