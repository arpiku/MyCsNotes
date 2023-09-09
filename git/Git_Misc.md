[[Git]]
#git #github
# Git Misc

#### Reseting Password
```bash

git config --global credential.helper osxkeychain


git config --global credential.helper wincred

# Or

git config --global --unset user.password

```

## Connecting to GitHub
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- After this save it to the director `/.ssh`
- Add the ssh Key to your gitHub account
- And afterwords when you will push code to that repo, it will automatically ask for the passphrase required to access the GitHub‘.