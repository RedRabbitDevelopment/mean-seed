should = require 'should'
describe 'another test', ->
	it 'should fail', ->
		'another'.should.equal 'another'
		'brother'.should.equal 'brother'
