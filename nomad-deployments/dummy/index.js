const server = Bun.serve({
    port: 3000,
    routes: {
        "/describe": describe,
    },
    fetch: (req) => {
        return new Response("not found", { status: 404 })
    }
})

console.log(`listening on http://localhost:${server.port}`)


function describe(req) {
    return Response.json({
        "api": "/describe",
        "name": `${process.env.APP_NAME}`,
        "caller": `${req.headers.get("host")}`,
    })
}