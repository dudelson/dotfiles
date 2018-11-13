# Dotfiles
This repo houses my dotfiles for the various unix systems I use (or have used).

## Included Configurations

- awesome: awesome window manager config
- git: general git settings and gitignore template
- kitty: terminal emulator config
- powerline: powerline for zsh config
- spacemacs: my main editor configuration
- vim: not my main editor anymore, but still comes in handy
- weechat: IRC config
- xorg: xinitrc config
- zsh: z shell config

## Configuration and Profile Management
Dotfiles are installed using dotbot. scripts/install (provided by dotbot) is idempotent, meaning I can use it to do either a first-time install or an update on an existing system.
Dotbot reads dotbot.yaml, which tells it how to symlink the various configs to the proper user directories.

Profiles are managed using git patches. I decided not to use git branches for this purpose, since they'd be like 90% the same and it just feels like unnecessary clutter.
So instead, the profiles/ directory contains a subdirectory for each profile I use (at the time of writing, profiles have a one-to-one correspondence with machines, but
in principle two separate machines that require identical configuration could share a profile). The subdirectory contains one or more patch files, which describe how that
profile's configuration differs from the master branch. Therefore, the install process is:

1. Clone this repository
2. Make a local git branch called "local" based on master, which will be for the local configuration
3. Apply the git patches for the profile you want to use using `git am` (if you want to make a new profile, skip this step)
4. Run scripts/install

The update process is similar. Changes to the local configuration should be committed to the local branch. In general, such changes can be separated into those which are
generally applicable (and should therefore be added to master) and those which are profile-specific. Changes are split into multiple commits as appropriate, and those commits
which contain changes in the latter category are marked with "[local]" in the commit message. Once the commits have been committed to the local branch, the generally-applicable
ones (i.e. those commits not prefixed with "[local]" in the commit message) are cherry-picked to master. At this point, you may have to regenerate the patch files.

