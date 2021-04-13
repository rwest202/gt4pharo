Class {
	#name : #GtPharoTemplateScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #'generated-initialization' }
GtPharoTemplateScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'false' 2) #(4 'nil' 3) #(4 'self' 33) #(4 'super' 34) #(4 'thisContext' 35) #(4 'true' 1))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtPharoTemplateScanner >> barId [
	^ 6
]

{ #category : #generated }
GtPharoTemplateScanner >> binaryId [
	^ 26
]

{ #category : #generated }
GtPharoTemplateScanner >> emptySymbolTokenId [
	^ 104
]

{ #category : #generated }
GtPharoTemplateScanner >> errorTokenId [
	^ 105
]

{ #category : #generated }
GtPharoTemplateScanner >> keywordId [
	^ 25
]

{ #category : #generated }
GtPharoTemplateScanner >> nameAssignmentId [
	^ 5
]

{ #category : #generated }
GtPharoTemplateScanner >> nameId [
	^ 4
]

{ #category : #generated }
GtPharoTemplateScanner >> negativeNumberId [
	^ 11
]

{ #category : #generated }
GtPharoTemplateScanner >> numberId [
	^ 10
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $$
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan9 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $-
		ifTrue: [ ^ self scan10 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	^ self scan1X12
]

{ #category : #generated }
GtPharoTemplateScanner >> scan10 [
	self recordMatch: #(26).
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(11).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan11 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self recordMatch: #(32).
			self step.
			currentCharacter == $`
				ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoTemplateScanner >> scan12 [
	self recordMatch: #(12).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan12 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X1 [
	self recordMatch: #(6 26).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X10 [
	[ self recordMatch: #(10).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X11 [
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan1X5 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ ('/=' includes: currentCharacter)
								or: [ (currentCharacter between: $? and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ ^ self scan1X4 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue:
					[ ^ self scan1X6 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X12 [
	currentCharacter == $:
		ifTrue:
			[ ^ self scan1X9 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scan1X3 ].
	currentCharacter == $>
		ifTrue:
			[ ^ self scan1X2 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $`
		ifTrue: [ ^ self scan11 ].
	currentCharacter == ${
		ifTrue:
			[ ^ self scan1X8 ].
	currentCharacter == $|
		ifTrue:
			[ ^ self scan1X1 ].
	currentCharacter == $}
		ifTrue:
			[ ^ self scan1X7 ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scan1X10 ].
	^ self scan1X11
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X2 [
	self recordMatch: #(15 26).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X3 [
	self recordMatch: #(14 26).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X4 [
	[ self recordMatch: #(26).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X5 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X6 [
	self recordMatch: #(25).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X7 [
	self recordMatch: #(24).
	self step.
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(37) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X8 [
	self recordMatch: #(16).
	self step.
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(36) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X9 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan2 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(30) ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoTemplateScanner >> scan3 [
	self step.
	currentCharacter == $#
		ifTrue: [ self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			(currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ])
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter == $!
						or: [ (currentCharacter between: $% and: $&)
								or: [ (currentCharacter between: $* and: $-)
										or: [ currentCharacter == $/
												or: [ (currentCharacter between: $< and: $@)
														or:
															[ '\|~' includes: currentCharacter ] ] ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter == $'
		ifTrue: [ ^ self scan4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan4 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(8).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoTemplateScanner >> scan5 [
	[ self recordMatch: #(8).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(8).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan6 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan6 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter == $:
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ ^ self scan6 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan7 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(8).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan8 [
	self step.
	^ self recordAndReportMatch: #(9)
]

{ #category : #generated }
GtPharoTemplateScanner >> scan9 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(7).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan9 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoTemplateScanner >> scanForToken [
	scope == #literalArray
		ifTrue:
			[ ^ self scanForTokenX1 ].
	scope == #default
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $$
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan9 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $-
		ifTrue: [ ^ self scan10 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scanForTokenX1X3 ].
	^ self scanForTokenX1X4
]

{ #category : #generated }
GtPharoTemplateScanner >> scanForTokenX1X1 [
	[ self recordMatch: #(26).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scanForTokenX1X2 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scanForTokenX1X3 [
	[ self recordMatch: #(10).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scanForTokenX1X4 [
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scanForTokenX1X2 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan12 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace #patternToken)
]