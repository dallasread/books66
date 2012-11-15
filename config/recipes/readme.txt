For setup on new machine:

	ADD USER
		adduser deployer
		adduser deployer sudo

	DEPLOY
		cap deploy:install
		cap deploy:setup
		cap deploy:cold # BUNDLE MAY HANG, IF SO RUN AGAIN

	KEYCHAIN ACCESS

		REMOTE
			sudo ssh git@github.com

		LOCAL
			cat ~/.ssh/id_rsa.pub | ssh deployer@208.68.37.206 'cat >> ~/.ssh/authorized_keys'
			ssh-add -K
	
	SEED DB
		REPLACE type="book" FOR class="book"
		REGEX <verse o(.*?)/> FOR <div class="verse" o$1>
		REGEX <verse e(.*?)/> FOR </div>
		REPLACE <w  FOR <div class="word" 
		REPLACE </w> FOR </div>
		REPLACE  lemma=" FOR  data-lemma="
		REPLACE  morph=" FOR  data-morph="
		REPLACE  osisID=" FOR  data-osisID="
		REPLACE  sID=" FOR  data-sID="
		REPLACE <transChange FOR <div class="transChange"
		REPLACE </transChange> FOR </div>
		REPLACE  src=" FOR  data-src="
		REGEX <milestone(.*?)/> FOR <div class="milestone"$1></div>
		REPLACE  resp=" FOR  data-resp="
		REPLACE  type=" FOR  data-type="
		
# EXPLANATIONS
w element has the following attributes in addition to those that it shares with other elements:
	• gloss Record comments on a particular word or its usage.
	• lemma Use to record the base form of a word.
	• morph Use to record grammatical information for a word.
	• POS Use to record the function of a word according to a particular view of the language's syntax.
	• src Use to record origin of the word.
	• xlit Use to record a transliteration of a word.

# OTHER
	• a
	• abbr
	• date
	• divineName
	• foreign
	• hi
	• index
	• inscription
	• lb
	• list
	• mentioned
	• milestone
	• name
	• note
	• q
	• reference
	• seg
	• speaker
	• title
	• transChange
	• w