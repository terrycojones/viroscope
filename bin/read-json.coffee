readStdinJSON = (callback) ->
    chunks = []
    process.stdin.setEncoding 'utf8'
    process.stdin.on 'readable', ->
        chunk = process.stdin.read()
        if chunk != null
            chunks.push chunk
    process.stdin.on 'end', ->
        callback JSON.parse chunks.join('')

module.exports.readStdinJSON = readStdinJSON
