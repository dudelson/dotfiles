;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion
      :variables
      auto-completion-return-key-behavior nil
      auto-completion-tab-key-behavior 'cycle
      :disabled-for org
      )
     ;; better-defaults
     c-c++
     fasd
     emacs-lisp
     git
     gtags
     lua
     ;; markdown
     ;; wait for next stable release before using this layer
     ;; fixes problem with linum where opening any helm buffer causes the line
     ;; numbers to all become "1"
     ;;nlinum
     org
     rust
     semantic
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     shell-scripts
     ;; spell-checking
     syntax-checking
     unimpaired
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     nlinum
     nlinum-relative
     highlight-escape-sequences
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents bookmarks projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-dark
                         spacemacs-dark
                         monokai)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (setq-default
   ;; whitespace settings copied from Elvind
   ;; whitespace-style '(face tabs tab-mark newline-mark)
   whitespace-display-mappings
   '((newline-mark 10 [172 10])
     (tab-mark 9 [9655 9]))

   ;; smartparens
   sp-highlight-pair-overlay nil
   sp-highlight-wrap-overlay nil
   sp-highlight-wrap-tag-overlay nil
   )
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VARIABLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq-default
   ;; escape everything with "jk" or "kj"
   evil-escape-key-sequence "jk"
   evil-escape-unordered-key-sequence t
   ;; don't move the cursor back by 1 when exiting insert mode
   evil-move-cursor-back nil
   ;; 10 lines of context at top and bottom of screen (and no jumpiness)
   scroll-margin 10
   scroll-conservatively 1000000
   ;; fill column indicator color
   fci-rule-color "#073642"
   ;; whitespace visualization settings
   whitespace-style '(face trailing tabs spaces space-before-tab indentation space-after-tab space-mark tab-mark)
   ;; make tab key behave as expected
   ;; enable rust code completion
   rust-enable-racer t
   )
  (setq
   ;; point racer to the rust source code
   racer-rust-src-path "/usr/src/rust/src"
   ;; try to make the autocompletions not look terrible
   company-tooltip-align-annotations t
   ;; temporary improvement to linum formatting
   linum-relative-format "%5s"
   )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TAB SETTINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; I've found it's easiest to put all tab- and indentation-related settings in
  ;; one place, because they're sort of tricky to get right, and this prevents
  ;; me from going crazy.
 (setq
  ;; prevent `<' and `>' from rounding to the nearest tabstop
  evil-shift-round nil
  ;; prevent unexpected tab behavior
  tab-always-indent t
  c-tab-always-indent t
  )
  ;; true tab characters are displayed as being <tab-width> spaces wide
  ;; it's best to have these three settings always agree with each other to
  ;; prevent interoperability problems with editors that can't separate tab width
  ;; from indentation settings
  ;; - from https://www.emacswiki.org/emacs/IndentationBasics
  (setq-default tab-width 4)
  (defvaralias 'c-basic-offset 'tab-width)
  (defvaralias 'cperl-indent-level 'tab-width)

  ;; set the tab-stop list according to the tab width
  (setq tab-stop-list (number-sequence tab-width 120 tab-width))

  ;; automatically indent when return is pressed
  (global-set-key (kbd "RET") 'newline-and-indent)

  ;; text-mode indentation settings
  ;; In text-mode, I want zero tab shenanigans.
  ;; This was the only way I could think of to get the tab key to reliably insert
  ;; a tab, but not simultaneously screw up things like `cc' and `o' in evil normal
  ;; state, which also depend on `insert-line-function'.
  (add-hook 'text-mode-hook (lambda ()
                              (define-key evil-insert-state-local-map (kbd "<tab>")
                                (lambda () (interactive) (insert-tab)))))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEY BINDINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; navagate by visual lines
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  ;; less awkward keybinding for expanding snippets
  ;; note: this overrides `evil-scroll-line-up`
  (define-key evil-insert-state-map (kbd "C-y") 'hippie-expand)
  ;; remap this function to a more intuitive key *and* free up C-a in insert mode
  (define-key evil-insert-state-map (kbd "C-p") 'evil-paste-last-insertion)
  ;; jump to beginning of (text) line in normal mode
  (define-key evil-insert-state-map (kbd "C-a") (kbd "C-o ^"))
  ;; jump to end of line in normal mode
  (define-key evil-insert-state-map (kbd "C-e") (kbd "C-o $"))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; HOOKS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; copied from Elvind
  (add-hook 'text-mode-hook 'auto-fill-mode)
  (add-hook 'makefile-mode-hook 'whitespace-mode)
  ;; turn on fill column indicator by default
  (add-hook 'prog-mode-hook (lambda () (spacemacs/toggle-fill-column-indicator-on) nil))
  ;; don't color delimiters in C-like code
  (add-hook 'c-mode-hook (lambda () (rainbow-delimiters-mode -1)))
  ;; auto-refersh magit status buffer when files change
  ;(add-hook 'after-save-hook 'magit-after-save-refresh-status)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ORG MODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; All org-mode settings need to be grouped
  ;; because spacemacs does not use the org-mode version that ships with emacs.
  ;; Thus any calls to org-mode functions or any attempt to set org-mode variables
  ;; outside of this `with-eval-after-load' statement will load the default org-mode
  ;; package instead of the spacemacs one, and will cause org-mode to behave weirdly.
  (with-eval-after-load 'org
    ;; indentation settings
    ;; This one's a work in progress...
    (setq
     ;; make subheadings indented by 4 spaces
     org-indent-indentation-per-level 4
     ;; also make plain sublists indented by 4 spaces
     org-list-indent-offset 2
     ;; my custom todo keywords
     ;; TODO items are those I plan to start in the immediate future
     ;; WAITING items are those I have started and am waiting for events out of
     ;;     my control to transpire before I can check off
     ;; ON HOLD items are those which I have postponed doing for the time being
     ;; DONE items have been completed
     org-todo-keywords '((sequence "TODO(t)" "|" "WAITING(w)" "ON HOLD(h)" "DONE(d)"))
     org-todo-keyword-faces '(
                              ("WAITING" . (:foreground "#b58900" :weight bold))
                              ("ON HOLD" . (:foreground "#dc322f" :weight bold))
                              )
     org-agenda-custom-commands '(("1" "Highest priority action items"
                                   ((tags-todo "+PRIORITY=\"A\""
                                    ((org-agenda-overriding-header "Priority A")
                                    (org-tags-match-list-sublevels nil)))))
                                  ("2" "High priority action items"
                                   ((tags-todo "+PRIORITY=\"B\""
                                    ((org-agenda-overriding-header "Priority B")
                                     (org-tags-match-list-sublevels nil)))))
                                  ("3" "Average priority action items"
                                   ((tags-todo "+PRIORITY=\"C\""
                                    ((org-agenda-overriding-header "Priority C")
                                     (org-tags-match-list-sublevels nil)))))
                                  ("d" "David's planner view"
                                   ((agenda "")
                                    (tags-todo "+PRIORITY=\"A\""
                                     ((org-agenda-skip-function
                                       '(org-agenda-skip-entry-if 'scheduled))
                                      (org-agenda-overriding-header
                                       "Highest Priority Unscheduled Tasks")))
                                    (tags-todo "+PRIORITY=\"B\""
                                     ((org-agenda-skip-function
                                       '(org-agenda-skip-entry-if 'scheduled))
                                      (org-agenda-overriding-header
                                       "High Priority Unscheduled Tasks"))))))
     ;; Make the tags not squished to the left in the agenda
     ;; Here they are right-aligned to column 100
     org-agenda-tags-column -100
     ;; don't insert a CLOSED timestamp when I complete a task
     org-log-done nil
     org-lowest-priority 69    ;; Priorities are in the range "A" to "E"
     org-default-priority 67   ;; Default priority is "C"
     )

    ;; C-RET and M-RET automatically enter insert state
    (define-key org-mode-map (kbd "C-<return>") (lambda ()
                                                  (interactive)
                                                  (org-insert-heading-respect-content)
                                                  (evil-insert 1)))
    (define-key org-mode-map (kbd "M-<return>") (lambda ()
                                                  (interactive)
                                                  (org-meta-return)
                                                  (evil-insert 1)))
    ;; (evil-set-initial-state 'org-agenda-mode 'emacs)
    ;;(define-key org-agenda-mode-map (kbd "C-*") 'org-agenda-filter-remove-all)


    ;; This is a cheap hack until I figure out a more robust way to change agenda
    ;; views within the agenda
    (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode "a" 'org-agenda)
    ;; (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode "1"
    ;;   (lambda ()
        ;; (interactive)
        ;; (org-agenda-run-series "TEST"
                               ;; ((tags-todo "+PRIORITY=\"C\""
                               ;;             ((org-agenda-overriding-header "Priority C")
                               ;;              (org-tags-match-list-sublevels nil)))))
                               ;; ))
  )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define-abbrev-table 'global-abbrev-table '(
                                              ("Flase" "False")
    ))
  ;; stop asking whether to save newly added abbrev when quitting emacs
  (setq save-abbrevs nil)
  ;; turn on abbrev mode globally
  (setq-default abbrev-mode t)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; highlight escape sequences
  (hes-mode)
  ;; highlight format strings in C-like languages
  (defvar font-lock-format-specifier-face		
    'font-lock-format-specifier-face
    "Face name to use for format specifiers.")

  (defface font-lock-format-specifier-face
    '((t (:foreground "OrangeRed1")))
    "Font Lock mode face used to highlight format specifiers."
    :group 'font-lock-faces)

  (add-hook 'c-mode-common-hook
            (lambda ()
              (font-lock-add-keywords nil
                                      '(("[^%]\\(%\\([[:digit:]]+\\$\\)?[-+' #0*]*\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\(\\.\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\)?\\([hlLjzt]\\|ll\\|hh\\)?\\([aAbdiuoxXDOUfFeEgGcCsSpn]\\|\\[\\^?.[^]]*\\]\\)\\)"
                                         1 font-lock-format-specifier-face t)
                                        ("\\(%%\\)" 
                                         1 font-lock-format-specifier-face t)) )))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; temporary nlinum setup (waiting for nlinum layer in next stable release)
  (require 'nlinum-relative)
  (nlinum-relative-setup-evil)                    ;; setup for evil
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (add-hook 'text-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0)      ;; delay
  (setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
  (setq nlinum-relative-offset 0)
  (setq nlinum-format "%d ")
 )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/org/spacemacs.org" "~/Dropbox/org/stuffff.org")))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(font-lock-keyword-face ((t (:foreground "#859900" :weight normal))))
 '(font-lock-preprocessor-face ((t (:foreground "#cb4b16"))))
 '(font-lock-variable-name-face ((t (:foreground "#839496"))))
 '(helm-selection ((t (:background "#073642" :underline nil))))
 '(linum ((t (:background "#073642" :foreground "#586e75"))))
 '(linum-relative-current-face ((t (:inherit linum :background "#002b36" :foreground "#839496" :weight bold))))
 '(org-level-1 ((t (:inherit nil :foreground "#de322f" :height 1.0))))
 '(org-level-2 ((t (:inherit nil :foreground "#859900" :height 1.0))))
 '(org-level-3 ((t (:inherit nil :foreground "#268bd2" :height 1.0))))
 '(org-level-4 ((t (:inherit nil :foreground "#b58900" :height 1.0))))
 '(org-level-5 ((t (:inherit nil :foreground "#2aa198"))))
 '(org-level-6 ((t (:inherit nil :foreground "#859900"))))
 '(org-level-7 ((t (:inherit nil :foreground "#cb4b16"))))
 '(org-level-8 ((t (:inherit nil :foreground "#268bd2")))))
