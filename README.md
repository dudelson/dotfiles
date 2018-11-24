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

I have a separate branch for each profile. And the branches really are separate --
there's no notion of keeping one or more branches "in sync" with each other, since
in many cases the configurations for different machines differ so much that this
wouldn't make sense. To this end, you may notice that there is no master branch.
Of course, many branches share a considerable amount of configuration, so these
changes are typically propagated between branches using `git cherry-pick`. Magit
helps a great deal with this.

## Installation
The install process is:

1. Clone this repository
2. If you're setting up a new configuration profile, make a new branch named
   after the profile. You can base this off the branch for an existing profile,
   if appropriate. Otherwise, just checkout the branch for the profile you
   wish to use.
3. If appropriate, make whatever initial changes you want before installing
4. Run scripts/install

If you setup a new branch, make sure to push it to github.

## Updates and Maintenance
The update process is:

1. Git commit
2. Git push

You can take configuration from other profiles by cherry-picking. Note that the
cherry-picked commit(s) probably won't apply without merge conflicts, so be
prepared to deal with these often.

**NOTE**: The READMEs should be kept in sync across branches so that they can
serve as a reference, regardless of the currently checked-out branch.
