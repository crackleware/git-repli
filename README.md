## Replication of git objects and refs by (encrypted) emails

### Requirements

- git
- gpg
- mailx + sendmail (or alternatives like getmail + mstmp, ...)

### Use

#### Setup:

- initializing new repository:

        $ cd GIT_REPO_DIR
        $ git init
        $ git config user.name '...'
        $ git config user.email '...'

- git-repli setup:

        $ cd GIT_REPO_DIR
        $ git-repli-set tag SUBJECT_TAG
        $ git-repli-set collaborators mycollaborator1@domainA.com ...

- if you want encrypted email communication exchange pub keys with
  collaborators (gpg --gen-key, gpg --export ..., gpg --import)

#### Full replication and synchronization iteration:

    $ cd GIT_REPO_DIR; git-repli-sync

#### Just send updates to collaborators:

    $ cd GIT_REPO_DIR; git-repli-send-updates

- to modify timestamp of the last bundle sending, e.g. to resend the last day's updates,
  execute "git-repli-set lasttimestamp $(( $(git-repli-get bundletimestamp) - 86400 ))"

#### Just receive updates from collaborators:

    $ cd GIT_REPO_DIR; git-repli-read-mail

#### Configuration vars (managed with git-repli-set/get/list):

- tag - tag inserted into email subject header, used to identify relevant emails
- collaborators - list of collaborator email addresses
- plain - if 1, plain (unencrypted) emails are used
- readmail - command for getting relevant emails 
- sendmail - command for sending emails
- protected_refs - regular expression for local refs that are protected during application of remote updates
- open - if 1, enable open submission by unsigned emails
- refetching - if 1, support full synchronization, git-repli-sync could send emails

#### Notes:

- local refs are protected from pointing to older commits during application of remote updates

### Todo

- splitting/joining bundles into/from multiple emails
- support for other transports

### Related

- "git bundle", "git format-patch" and "git am" commands

