## Replication of git objects and refs by (encrypted) emails

### Requirements

- git
- gpg
- sendmail (or alternative like msmtp)

### Usage example

Setup:
	
- if you want encrypted email communication exchange pub keys with
  collaborators (gpg --gen-key, gpg --export ..., gpg --import)
	
Send updates to collaborators:

	$ cd GIT_REPO_DIR
	$ GIT_REPLI_TAG=SOME_TAG git-repli-send-mail mycollaborator1@domainA.com ...

- for unencrypted emails, use GIT\_REPLI\_PLAIN=1
- for sendmail alternative, use GIT\_REPLI\_SENDMAIL=...

Receive updates from collaborators:

	$ GIT_REPLI_TAG=SOME_TAG my-git-repli-get-mail-script | (cd GIT_REPO_DIR; git-repli-parse-mail)

- for unencrypted emails, use "GIT\_REPLI\_PLAIN=1 git-repli-parse-mail ..."

### Todo

- real sync protocol and support for other transports

### Related

- "git format-patch" and "git am" commands

