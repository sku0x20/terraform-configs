const server = Bun.serve({
    port: 3000,
    routes: {
        "/describe": describe,
        "/call/:appId": call,
        "/*": new Response("not found", { status: 404 })
    },
})

console.log(`listening on http://localhost:${server.port}`)


function describe(req) {
    return Response.json({
        "api": "/describe",
        "name": `${process.env.APP_NAME}`,
        "referer": `${req.headers.get("referer")}`,
    })
}

async function call(req) {
    const appToCall = req.params.appId
    const f = await fetch(`http://${appToCall}/describe`, {
        headers: {
            referer: `${process.env.APP_NAME}`
        }
    })
    const resp = await f.json()
    return Response.json({
        "api": "/call",
        "name": `${process.env.APP_NAME}`,
        "toCall": `${appToCall}`,
        "resp": resp
    })
}