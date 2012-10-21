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
		cap deploy:seed