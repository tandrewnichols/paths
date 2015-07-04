expect = require('indeed').expect

describe 'cartesian path', ->
  Given -> @paths = require '../lib/paths'

  describe '.expand', ->
    context 'with no expansion', ->
      When -> @list = @paths.expand 'foo.bar.baz'
      Then -> expect(@list).to.deep.equal ['foo.bar.baz']

    context 'with expansion', ->
      context 'and brackets', ->
        When -> @list = @paths.expand 'foo.bar.[baz,quux]'
        Then -> expect(@list).to.deep.equal [
          'foo.bar.baz',
          'foo.bar.quux'
        ]

      context 'with braces', ->
        When -> @list = @paths.expand 'foo.bar.{baz,quux}'
        Then -> expect(@list).to.deep.equal [
          'foo.bar.baz',
          'foo.bar.quux'
        ]

      context 'with angled brackets', ->
        When -> @list = @paths.expand 'foo/bar/<baz,quux>'
        Then -> expect(@list).to.deep.equal [
          'foo/bar/baz',
          'foo/bar/quux'
        ]

      context 'multiple expansions', ->
        When -> @list = @paths.expand 'foo.bar.[baz,quux].hello.world[.js,-spec.coffee]'
        Then -> expect(@list).to.deep.equal [
          'foo.bar.baz.hello.world.js',
          'foo.bar.quux.hello.world.js',
          'foo.bar.baz.hello.world-spec.coffee',
          'foo.bar.quux.hello.world-spec.coffee'
        ]