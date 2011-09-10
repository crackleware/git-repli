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
    $ git-repli-send-mail SUBJECT_TAG mycollaborator1@domainA.com ...

- for unencrypted emails, use GIT\_REPLI\_PLAIN=1
- for sendmail alternative, use GIT\_REPLI\_SENDMAIL=...
- to modify timestamp of the last bundle sending, e.g. to set at 1 day
  before the last bundle was sent, use "git-repli-update-timestamp $(expr $(git config git-repli.bundletimestamp) - 86400)"

Receive updates from collaborators:

    $ my-git-repli-get-mail-script SUBJECT_TAG | (cd GIT_REPO_DIR; git-repli-parse-mail)

- for unencrypted emails, use "GIT\_REPLI\_PLAIN=1 git-repli-parse-mail ..."
- for local refs protection, use use "GIT\_REPLI\_PROTECT_REFS=regexp git-repli-parse-mail ..."

### Todo

- real sync protocol and support for other transports

### Related

- "git bundle", "git format-patch" and "git am" commands

