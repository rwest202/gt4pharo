Class {
	#name : #GtTraitsDefinition,
	#superclass : #GtCompositeDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtTraitsDefinition class >> fromClass: aClass [
	^ self new fromClass: aClass
]

{ #category : #'instance creation' }
GtTraitsDefinition class >> fromTrait: aTrait [
	^ self new fromTrait: aTrait
]

{ #category : #'api - traits' }
GtTraitsDefinition >> addTraitNamed: aSymbolOrString [
	| aTraitName aTrait aTraitDefinition |
	
	aTraitName := aSymbolOrString asSymbol.
	
	(self hasDefinitionNamed: aTraitName)
		ifTrue: [ self errorTraitAlreadyAdded: aTraitName ].
		
	(self doesTraitExist: aTraitName)
		ifFalse: [ self errorTraitDoesNotExist: aTraitName ].
	
	aTrait := self class environment at: aTraitName.
	aTraitDefinition := GtTraitDefinition fromTrait: aTrait.
	definitions := definitions copyWith: aTraitDefinition.

	self notifyTraitAdded: aTraitDefinition
]

{ #category : #converting }
GtTraitsDefinition >> asDefinitionString [
	self isEmpty
		ifTrue: [ ^ '{}' ].

	^ String streamContents: [ :stream | 
		definitions
			do: [ :each | stream nextPutAll: each name ]
			separatedBy: [ stream nextPutAll: ' + ' ].
		stream space ]
]

{ #category : #'api - accepting' }
GtTraitsDefinition >> differenceWith: aGtTraitsDefinition [
	| theDifference |

	theDifference := GtTraitsDefinitionDifference new.

	GtCodeDefinitionDifference
		difference: self all
		with: aGtTraitsDefinition all
		addedDo: [ :eachTrait | theDifference add: (GtTraitAddedToDefinitionDifference new traitName: eachTrait name) ]
		removedDo: [ :eachTrait | theDifference add: (GtTraitRemovedFromDefinitionDifference new traitName: eachTrait name) ].

	^ theDifference
]

{ #category : #'api - traits' }
GtTraitsDefinition >> doesTraitExist: aTraitName [
	<return: #Boolean>

	^ self class environment
		at: aTraitName
		ifPresent: [ :aGlobal | aGlobal isTrait ]
		ifAbsent: [ false ]
]

{ #category : #'private - errors' }
GtTraitsDefinition >> errorTraitAlreadyAdded: aSymbol [ 
	"Create an error notification that there is already a trait with a given name"

	GtBehaviorCoderHeaderTraitAlreadyAddedError signalFor: aSymbol
]

{ #category : #'private - errors' }
GtTraitsDefinition >> errorTraitDoesNotExist: aSymbol [ 
	"Create an error notification that a trait with a given name does not exist in the environment"

	GtBehaviorCoderHeaderTraitDoesNotExistError signalFor: aSymbol
]

{ #category : #'private - errors' }
GtTraitsDefinition >> errorTraitNotFound: aSymbol [ 
	"Create an error notification that there is no trait with a given name"

	GtBehaviorCoderHeaderTraitNotFoundError signalFor: aSymbol
]

{ #category : #testing }
GtTraitsDefinition >> exists [
	^ definitions allSatisfy: [ :each | each exists ]
]

{ #category : #initialization }
GtTraitsDefinition >> fromClass: aClass [
	definitions := aClass traitComposition traits collect: [ :eachTrait | (GtTraitDefinition fromTrait: eachTrait) parent: self ]
]

{ #category : #initialization }
GtTraitsDefinition >> fromTrait: aTrait [
	definitions := aTrait traitComposition traits collect: [ :eachTrait | (GtTraitDefinition fromTrait: eachTrait) parent: self ]
]

{ #category : #'private - notifying' }
GtTraitsDefinition >> notifyTraitAdded: aGtTraitDefinition [
	self dispatchEvent: (GtBehaviorTraitAdded new
		owner: self parent;
		trait: aGtTraitDefinition)
]

{ #category : #'private - notifying' }
GtTraitsDefinition >> notifyTraitRemoved: aGtTraitDefinition [
	self dispatchEvent: (GtBehaviorTraitRemoved new
		owner: self parent;
		trait: aGtTraitDefinition)
]

{ #category : #'private - notifying' }
GtTraitsDefinition >> notifyTraitRenamed: aGtTraitDefinition from: anOldName to: aNewName [
	self dispatchEvent: (GtBehaviorTraitRenamed new
		owner: self parent;
		trait: aGtTraitDefinition;
		oldName: anOldName;
		newName: aNewName)
]

{ #category : #'api - traits' }
GtTraitsDefinition >> removeTraitNamed: aSymbol [
	| aRemovedTrait |
	
	(self hasDefinitionNamed: aSymbol)
		ifFalse: [ self errorTraitNotFound: aSymbol ].
	
	aRemovedTrait := self traitNamed: aSymbol.
	definitions := definitions copyWithout: aRemovedTrait.
	self notifyTraitRemoved: aRemovedTrait
]

{ #category : #'api - traits' }
GtTraitsDefinition >> renameTraitNamed: aCurrentName to: aNewName [
	| aRenamedTrait |
	
	(self hasDefinitionNamed: aCurrentName)
		ifFalse: [ self errorTraitNotFound: aCurrentName ].
		
	(self hasDefinitionNamed: aNewName)
		ifTrue: [ self errorTraitAlreadyAdded: aCurrentName ].

	aRenamedTrait := self traitNamed: aCurrentName.
	aRenamedTrait name: aNewName.
	
	self
		notifyTraitRenamed: aRenamedTrait
		from: aCurrentName
		to: aNewName
]

{ #category : #'api - traits' }
GtTraitsDefinition >> traitNamed: aSymbol [
	<return: #GtTraitDefinition>
	
	^ self
		definitionNamed: aSymbol
		ifNone: [ self errorTraitNotFound: aSymbol ]
]