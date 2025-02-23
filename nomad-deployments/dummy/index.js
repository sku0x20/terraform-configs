const server = Bun.serve({
    port: 3000,
    routes: {
        "/describe": describe,
        "/call/static": () => {
            console.log(`static call`);
            return call(process.env.APP_OTHER)
        },
        "/call/dynamic": () => {
            console.log(`dynamic call`);
            return new Response("todo", { status: 500 })
        },
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

async function call(otherAppAddress) {
    console.log(`call other -> ${otherAppAddress}`);
    const f = await fetch(`http://${otherAppAddress}/describe`, {
        headers: {
            referer: `${process.env.APP_NAME}`
        }
    })
    const resp = await f.json()
    return Response.json({
        "api": "/call",
        "name": `${process.env.APP_NAME}`,
        "other": `${otherAppAddress}`,
        "resp": resp
    })
}