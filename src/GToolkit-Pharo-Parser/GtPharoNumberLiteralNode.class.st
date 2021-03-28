Class {
	#name : #GtPharoNumberLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoNumberLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNumberLiteral: self
]

{ #category : #accessing }
GtPharoNumberLiteralNode >> guessType: completionStrategy [
	^ [ (Number readFrom: value source) class ]
		on: Error
		do: [ :ex | ex return: Number ]
]

{ #category : #accessing }
GtPharoNumberLiteralNode >> literalValue [
	^ Number
		readFrom: self value value
		ifFail: [ 0 ]
]

{ #category : #generated }
GtPharoNumberLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoNumberLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoNumberLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]