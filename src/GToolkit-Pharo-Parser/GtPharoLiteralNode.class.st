Class {
	#name : #GtPharoLiteralNode,
	#superclass : #GtPharoValueNode,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLiteral: self
]

{ #category : #testing }
GtPharoLiteralNode >> isLiteral [
	^ true
]

{ #category : #accessing }
GtPharoLiteralNode >> literalValue [
	^ self subclassResponsibility
]