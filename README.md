## Replication of git objects and refs by (encrypted) higher latency messages

### Requirements

- git
- gpg
- a message transport, for example:
  - email based - scriptable MUA + MTA/MDA (heirloom-mailx + sendmail, getmail + msmtp, ...)
  - sneakernet
  - other custom transports

Example transport scripts are in _transports_ subdir.

### Use

#### Setup:

- initializing new repository:

        $ mkdir -p GIT_REPO_DIR
        $ cd GIT_REPO_DIR
        $ git init
        $ git config user.name '...'
        $ git config user.email 'myself@domainM.com'

- git-repli setup:

        $ cd GIT_REPO_DIR
        $ git-repli-set tag SUBJECT_TAG
        $ git-repli-set collaborators mycollaborator1@domainA.com ...
        $ git-repli-set readmessages ... # optional
        $ git-repli-set sendmessages ... # optional

- if you want encrypted communication exchange pub keys with
  collaborators (gpg --gen-key, gpg --export ..., gpg --import)

#### Full replication and synchronization iteration:

    $ cd GIT_REPO_DIR; git-repli-sync

#### Just send updates to collaborators:

    $ cd GIT_REPO_DIR; git-repli-send-updates

- to modify timestamp of the last bundle sending, e.g. to resend the last day's updates,
  execute "git-repli-set lasttimestamp $(( $(git-repli-get bundletimestamp) - 86400 ))"

#### Just receive updates from collaborators:

    $ cd GIT_REPO_DIR; git-repli-read-messages

#### Configuration vars (managed with git-repli-set/get/list):

- tag - tag inserted into message subject header, used to identify relevant messages
- collaborators - list of collaborator addresses
- plain - if 1, plain (unencrypted) messages are used
- readmessages - command for getting relevant messages 
- sendmessages - command for sending messages
- protected_refs - regular expression for local refs that are protected during application of remote updates
- open - if 1, enable open submission by unsigned messages
- refetching - if 1, support full synchronization, git-repli-sync could send messages

#### Notes:

- local refs are protected from pointing to older commits during application of remote updates

### Todo

- add git-send-mail transport example
- explicit remotely initiated synchronization
- splitting/joining git-repli messages into/from multiple transport messages
- more efficient synchronization/refetching (better basis for "git bundle create")
- additional example transport scripts

### Related

- "git bundle", "git format-patch" and "git am" commands

### Contact

predrg@gmail.com
