canvas = document.createElement("canvas")
ctx = canvas.getContext("2d")
canvas.width = 640
canvas.height = 480
document.body.appendChild(canvas)

bgReady = false
bgImage = new Image()
bgImage.onload = ->
    bgReady = true
    return
bgImage.src = "media/images/Space.png"

heroReady = false
heroImage = new Image()
heroImage.onload = ->
    heroReady = true
    return
heroImage.src = "media/images/Noahs Starfighter.png"

monsterReady = false

monsterImage = new Image()
monsterImage.onload = ->
    monsterReady = true
    return
monsterImage.src = "media/images/StandardEnemyShip.png"

hero =
    speed: 320
monster = {}
monstersCaught = 0

keysDown = {}

addEventListener("keydown", (e)->
        keysDown[e.keyCode] = true
        return
    ,false)

addEventListener("keyup", (e)->
        delete keysDown[e.keyCode]
        return
    ,false)

reset = ->
    hero.x = canvas.width/2
    hero.y = canvas.height/2

    monster.x = 32 + (Math.random() * (canvas.width - 64))
    monster.y = 32 + (Math.random() * (canvas.height - 64))
    return

update = (modifier)->
    if 38 of keysDown
        hero.y -= hero.speed * modifier
    if 40 of keysDown
        hero.y += hero.speed * modifier
    if 37 of keysDown
        hero.x -= hero.speed * modifier
    if 39 of keysDown
        hero.x += hero.speed * modifier

    if hero.x <= monster.x+32 && monster.x <= hero.x+32 && hero.y <= monster.y+32 && monster.y <= hero.y+32
        ++monstersCaught
        reset()
    return

render = ->
    if bgReady
        ctx.drawImage(bgImage, 0, 0)
    if heroReady
        ctx.drawImage(heroImage, hero.x, hero.y)
    if monsterReady
        ctx.drawImage(monsterImage, monster.x, monster.y)
    ctx.fillStyle = "rgb(250,250,250)"
    ctx.font = "24px Helvetica"
    ctx.textAlign = "left"
    ctx.textBaseline = "top"
    ctx.fillText("Goblins caught: " + monstersCaught, 32, 32)
    return

main = ->
    now = Date.now()
    delta = now-previousTime

    update(delta / 1000)
    render()

    @previousTime = now

    requestAnimationFrame(main)

    console.log keysDown
    return

w = window
requestAnimationFrame = w.requestAnimationFrame || w.webkitRequestAnimationFrame || w.msRequestAnimationFrame || w.mozRequestAnimationFrame

@previousTime = Date.now()

reset()
main()
    
