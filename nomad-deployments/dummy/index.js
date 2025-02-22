const server = Bun.serve({
    port: 3000,
    fetch: (req) => {
        return new Response("from Bun!")
    }
})

console.log(`listening on http://localhost:${server.port}`)