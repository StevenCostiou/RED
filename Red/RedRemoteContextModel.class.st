"
I model a remote context.

I store all information of a context as displayed by a debugger under a string form to be transmitted and displayed remotely.

I know the hash of the context I model.
I do not know the map of hashs <-> contexts, see RedDebugger class for that.
"
Class {
	#name : #RedRemoteContextModel,
	#superclass : #Object,
	#instVars : [
		'contextHash',
		'sender',
		'receiverClassName',
		'methodSelector',
		'packageName'
	],
	#category : #Red
}

{ #category : #accessing }
RedRemoteContextModel >> contextHash [

	^ contextHash
]

{ #category : #accessing }
RedRemoteContextModel >> contextHash: anObject [

	contextHash := anObject
]

{ #category : #accessing }
RedRemoteContextModel >> methodSelector [

	^ methodSelector
]

{ #category : #accessing }
RedRemoteContextModel >> packageName [

	^ packageName
]

{ #category : #printing }
RedRemoteContextModel >> printReceiverClassInContext: aContext [

	| receiverClass methodClass |
	receiverClass := aContext receiver class.
	methodClass := aContext method methodClass.
	receiverClass == methodClass ifTrue: [ ^ receiverClass name ].
	^ (WriteStream on: String new)
		  nextPutAll: receiverClass name;
		  space;
		  nextPut: $(;
		  nextPutAll: methodClass name;
		  nextPut: $);
		  contents
]

{ #category : #accessing }
RedRemoteContextModel >> receiverClassName [

	^ receiverClassName
]

{ #category : #accessing }
RedRemoteContextModel >> sender [

	^ sender
]

{ #category : #accessing }
RedRemoteContextModel >> sender: anObject [

	sender := anObject
]

{ #category : #visiting }
RedRemoteContextModel >> visitContext: aContext [

	| str |
	str := WriteStream on: String new.
	aContext printOn: str.
	contextHash := aContext hash.
	receiverClassName := self printReceiverClassInContext: aContext.
	methodSelector := aContext method isCompiledBlock
		          ifTrue: [ aContext method sourceNode sourceCode ]
		          ifFalse: [ aContext method selector ].
	packageName := aContext method package
		           ifNil: [ '-' ]
		           ifNotNil: [ :p | p name asString ].
	aContext sender ifNotNil: [ :s | 
		sender := self class new visitContext: s ]
]