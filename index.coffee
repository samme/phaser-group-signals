"use strict"

{Phaser} = this
{Group, Signal} = Phaser
{LifeSpan} = Phaser.Component

_add = Group::add

Group::add = (child, silent, index) ->
  if this is child.parent
    return child
  result = _add.call this, child, silent, index
  if @_onChildAdded and not silent
    @onChildAdded.dispatch child, this
  result

_remove = Group::remove

Group::remove =(child, destroy, silent) ->
  result = _remove.call this, child, destroy, silent
  if @_onChildRemoved and not silent and result
    @onChildRemoved.dispatch child, this
  result

_revive = LifeSpan::revive

LifeSpan::revive = (health) ->
  _revive.call this, health
  if @parent?._onChildRevived
    @parent.onChildRevived.dispatch this, @parent
  this

_kill = LifeSpan::kill

LifeSpan::kill = ->
  _kill.call this
  if @parent?._onChildKilled
    @parent.onChildKilled.dispatch this, @parent
  this

for obj in [
  Phaser.BitmapText
  Phaser.Creature
  Phaser.Graphics
  Phaser.Image
  Phaser.Rope
  Phaser.Sprite
  Phaser.Text
  Phaser.TileSprite
] when obj and obj::components.LifeSpan

  obj::kill   = LifeSpan::kill
  obj::revive = LifeSpan::revive

Object.defineProperty Group.prototype, "onChildAdded",
  get: -> @_onChildAdded or (@_onChildAdded = new Signal)

Object.defineProperty Group.prototype, "onChildRemoved",
  get: -> @_onChildRemoved or (@_onChildRemoved = new Signal)

Object.defineProperty Group.prototype, "onChildKilled",
  get: -> @_onChildKilled or (@_onChildKilled = new Signal)

Object.defineProperty Group.prototype, "onChildRevived",
  get: -> @_onChildRevived or (@_onChildRevived = new Signal)
