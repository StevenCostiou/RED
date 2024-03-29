Class {
	#name : #RedRemoteContextModelTest,
	#superclass : #RedDebuggerTestCase,
	#instVars : [
		'context',
		'sender'
	],
	#category : #'Red-Tests'
}

{ #category : #running }
RedRemoteContextModelTest >> setUp [

	super setUp.

	sender := Context
		          sender: nil
		          receiver: 1 @ 1
		          method: Point >> #+
		          arguments: { 1 }.
	context := Context
		           sender: sender
		           receiver: 1 @ 1
		           method: Point >> #+
		           arguments: { 1 }
]

{ #category : #tests }
RedRemoteContextModelTest >> testModelBlockContext [
	|model|
	context := [1+1] asContext.
	model := RedRemoteContextModel new.
	model visitContext: context.
	
	self assert: model sender equals: nil.	
	self assertModel: model modelsContext: context.
	self assert: model isBlock.
	self assert: model blockSource equals: context method sourceNode sourceCode

















































]

{ #category : #tests }
RedRemoteContextModelTest >> testVisitContext [
	|model|
	model := RedRemoteContextModel new.
	model visitContext: context.
	
	self assert: model sender contextHash equals: context sender hash.	
	self assertModel: model modelsContext: context.
	self assertModel: model sender modelsContext: sender.
	
	self deny: model isBlock.
	self deny: model sender isBlock.

















































]
