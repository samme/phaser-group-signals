quote = (str) ->
  if str then "'#{str}'" else str

log = (obj, group, msg) ->
  console.log "#{quote(obj.name) or '[unnamed]'} #{msg} in #{quote(group.name) or '[unnamed group]'}"
  return

new Phaser.Game
  width: 600
  height: 150
  state:
    create: ->
      world = @world
      world.onChildAdded  .add log, null, null, 'added'
      world.onChildRemoved.add log, null, null, 'removed'
      world.onChildKilled .add log, null, null, 'killed'
      world.onChildRevived.add log, null, null, 'revived'
      text = @add.text 0, 0, 'see console 👀',
        fill: 'white'
        font: '100px cursive'
      group = @add.group world, 'group'
      group.onChildAdded  .add log, null, null, 'added'
      group.onChildRemoved.add log, null, null, 'removed'
      group.onChildKilled .add log, null, null, 'killed'
      group.onChildRevived.add log, null, null, 'revived'
      nestedGroup = group.add @add.group(null, 'nestedGroup')
      sprite = @add.sprite()
      sprite.name = 'sprite'
      group.add sprite
      sprite.kill()
      sprite.revive()
      group.remove sprite
      return

