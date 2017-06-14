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
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     csv
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
     finance
     emacs-lisp
     (evil-snipe
      :variables
      evil-snipe-enable-alternate-f-and-t-behaviors t
      evil-snipe-scope 'visible
      evil-snipe-repeat-scope 'visible
      )
     git
     gtags
     haskell
     java
     javascript
     lua
     (latex
      :variables
      latex-build-command "LaTeX"
      )
     (markdown
      ;; :variables markdown-live-preview-engine 'vmd
      )
     nlinum
     ocaml
     org
     pdf-tools
     python
     (ranger
      :variables
      ranger-cleanup-eagerly t
      )
     react
     rust
     semantic
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     shell-scripts
     (spell-checking
      :variables spell-checking-enable-by-default nil
      )
     syntax-checking
     ;; version-control
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     highlight-escape-sequences
     android-mode
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

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
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
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
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
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
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
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
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
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
   ;; point android-mode to android sdk
   android-mode-sdk-dir "/home/david/.local/android/android-sdk-linux"
   ;; fix "can't find project root" error when creating android projects
   android-mode-builder 'gradle
   android-mode-root-file-plist '(ant "AndroidManifest.xml"
                                  maven "AndroidManifest.xml"
                                  gradle "gradlew")
   ;; try to make the autocompletions not look terrible
   company-tooltip-align-annotations t
   ;; temporary improvement to linum formatting
   ;; set latex pdf viewer
   TeX-view-program-selection '((output-pdf "PDF Tools"))
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
  ;; javascript/react indentation settings
  (setq-default
   js2-basic-offset tab-width
   css-indent-offset tab-width
   web-mode-markup-indent-offset tab-width
   web-mode-css-indent-offset tab-width
   web-mode-code-indent-offset tab-width
   web-mode-attr-indent-offset tab-width)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEY BINDINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; less awkward keybinding for expanding snippets
  ;; note: this overrides `evil-scroll-line-up`
  (define-key evil-insert-state-map (kbd "C-y") 'hippie-expand)
  ;; remap this function to a more intuitive key *and* free up C-a in insert mode
  (define-key evil-insert-state-map (kbd "C-p") 'evil-paste-last-insertion)
  ;; jump to beginning of (text) line in normal mode
  (define-key evil-insert-state-map (kbd "C-a") (kbd "C-o ^"))
  ;; jump to end of line in normal mode
  (define-key evil-insert-state-map (kbd "C-e") (kbd "C-o $"))
  ;; C-s is /, / is snipe-s, and s is vim normal mode s
  (define-key evil-normal-state-map (kbd "s") 'evil-substitute)
  (define-key evil-normal-state-map (kbd "S") 'evil-change-whole-line)
  (define-key evil-normal-state-map (kbd "/") 'evil-snipe-s)
  (define-key evil-normal-state-map (kbd "?") 'evil-snipe-S)
  (define-key evil-normal-state-map (kbd "C-s") 'evil-search-forward)
  ;; I can't use C-x in emacs for decrementing numbers, so rebind these to
  ;; + and - instead
  (define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)

  ;; Trying to build good habits
  ;; These functions limit me to one keypress per second in evil-normal-state
  ;; In the case of j and k, I should be using a count
  ;; In the case of h and l, I should be using f and t instead

  ;; these vars store the last time that their respective key was pressed, in
  ;; the format returned by `current-time'
  (defvar dudelson/evil-habit-builder-last-keypress-j (current-time))
  (defvar dudelson/evil-habit-builder-last-keypress-k (current-time))
  (defvar dudelson/evil-habit-builder-last-keypress-h (current-time))
  (defvar dudelson/evil-habit-builder-last-keypress-l (current-time))
  (defun dudelson/evil-habit-builder (count)
    "Prevents the victim (user) from pressing the h, j, k, or l keys in
succession more than once a second without a count"
    (interactive "p")
    (let* ((r (recent-keys))
           (key (aref r (- (length r) 1)))
           (prev-key (aref r (- (length r) 2)))
           (cur (current-time))
           (prev
            (cond
             ((= key ?j) 'dudelson/evil-habit-builder-last-keypress-j)
             ((= key ?k) 'dudelson/evil-habit-builder-last-keypress-k)
             ((= key ?h) 'dudelson/evil-habit-builder-last-keypress-h)
             ((= key ?l) 'dudelson/evil-habit-builder-last-keypress-l)
             (t "o shit waddup") ; this should never happen
             ))
           (delta (time-subtract cur (symbol-value prev))))

      ;; predicate checks if user pressed the same key twice consecutively,
      ;; without using a count, in the space of less than a second
          (if (and (= key prev-key) (= count 1) (= 0 (nth 1 delta)))
               ;; then
               (message
                (cond
                 ((or (= key ?j) (= key ?k)) "Use a count!")
                 ((or (= key ?h) (= key ?l)) "Use f or t!")))
               ;; else
               (funcall
                (cond
                 ((= key ?j) 'evil-next-visual-line)
                 ((= key ?k) 'evil-previous-visual-line)
                 ((= key ?h) 'evil-backward-char)
                 ((= key ?l) 'evil-forward-char)
                 (t nil) ; should never happen
                ) count))
          (set prev cur)))

  ;; ensure that evil-habit-builder is non-repeatable (because it is a motion)
  (evil-set-command-property 'dudelson/evil-habit-builder :repeat nil)

  ;; now let's build those damn habits!
  (define-key evil-normal-state-map (kbd "h") 'dudelson/evil-habit-builder)
  (define-key evil-normal-state-map (kbd "j") 'dudelson/evil-habit-builder)
  (define-key evil-normal-state-map (kbd "k") 'dudelson/evil-habit-builder)
  (define-key evil-normal-state-map (kbd "l") 'dudelson/evil-habit-builder)

  ;; `SPC o o' opens my planner from anywhere in emacs
  (defvar dudelson/toggle-planner-enabled nil
    "Whether the planner view is enabled")
  (defvar dudelson/toggle-planner-window-config nil
    "Saves the window config so it can be restored later")
  (defun dudelson/toggle-planner ()
    "Toggles my custom planner view
When toggled on, displays my org file on the left, and my custom agenda on the right.
When toggled off, restores the window layout from before the last time it was toggled on"
    (interactive)
    (if dudelson/toggle-planner-enabled
        ;; restore previous window configuration
        (set-window-configuration dudelson/toggle-planner-window-config)
      ;; otherwise store window configuration so it can be restored later
      (setq dudelson/toggle-planner-window-config (current-window-configuration))
      (find-file "~/s/doc/org/stuffff.org")
      (delete-other-windows)
      ;; here's a hack to open the agenda, since I don't know a better way to open
      ;; a custom agenda
      (setq unread-command-events (listify-key-sequence ",ad"))
      )
    ;; toggle the thingy
    (setq dudelson/toggle-planner-enabled (not (symbol-value dudelson/toggle-planner-enabled)))
    (message "Toggled planner view %s" dudelson/toggle-planner-enabled))

  (spacemacs/set-leader-keys "oo" 'dudelson/toggle-planner)

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
  ;; save buffer on focus lost
  ;; (add-hook 'focus-out-hook 'save-buffer)
  ;; disable relative line numbers on focus lost
  ;; (add-hook 'focus-out-hook 'nlinum-relative-off)
  ;; (add-hook 'focus-in-hook 'nlinum-relative-on)
  ;; auto-refersh magit status buffer when files change
  ;(add-hook 'after-save-hook 'magit-after-save-refresh-status)
  ;; disable evilification of Info pages
  (evil-set-initial-state 'Info-mode 'emacs)
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
     ;; default place to look for org files
     org-directory "~/s/doc/org"
     ;; files that appear in the agenda
     org-agenda-files (list
                       (concat org-directory "/stuffff.org")
                       (concat org-directory "/spacemacs.org")
                       (concat org-directory "/laptop.org")
                       )
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
     org-todo-keywords '((sequence "TODO(t)" "SCHED(s)" "HW(r)" "|" "WAITING(w)" "ON HOLD(h)" "DONE(d)"))
     org-todo-keyword-faces '(
                              ("WAITING" . (:foreground "#b58900" :weight bold))
                              ("ON HOLD" . (:foreground "#dc322f" :weight bold))
                              ("SCHED" . (:foreground "#6c71c4" :weight bold))
                              ("HW" . (:foreground "#cb4b16" :weight bold))
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
                                  ("R" "Homework"
                                   ((todo "HW"
                                               ((org-agenda-overriding-header "Homework")
                                                (org-tags-match-list-sublevels nil)))))
                                  ("d" "David's planner view"
                                   ((agenda "")
                                    (todo "HW"
                                     ((org-agenda-skip-function
                                       '(org-agenda-skip-entry-if 'scheduled))
                                      (org-agenda-overriding-header
                                       "Homework")))
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
     org-log-done nil ;; don't insert a CLOSED timestamp when I complete a task
     org-lowest-priority 69    ;; Priorities are in the range "A" to "E"
     org-default-priority 68   ;; Default priority is "D"
     ;; refile settings
     org-refile-targets '((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9))
     org-outline-path-complete-in-steps nil         ;; Refile in a single go
     org-refile-use-outline-path t                  ;; Show full paths for refiling
     ;; capture settings
     org-default-notes-file (concat org-directory "/stuffff.org")
     org-capture-templates
     `(("t" "TODO" entry (file+headline ,(concat org-directory "/stuffff.org") "captured")
        "* TODO %?\n")
       ("s" "SCHED" entry (file+headline ,(concat org-directory "/stuffff.org") "captured")
        "* SCHED %?\n"))

     ;; deadline settings
     org-deadline-warning-days 1
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
    ;; `org-refile' is bound to ,R by default, but ,r is also free, and I don't
    ;; want to hit shift if I don't have to
    (spacemacs/set-leader-keys-for-major-mode 'org-mode "r" 'org-refile)
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
 )

 ;; start emacs server
 (server-start)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/s/doc/org/stuffff.org" "~/s/doc/org/spacemacs.org" "~/s/doc/org/laptop.org")))
 '(package-selected-packages
   (quote
    (intero hlint-refactor hindent helm-hoogle haskell-snippets flycheck-haskell company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode powerline ranger spinner log4e multiple-cursors hide-comnt evil-snipe bind-key packed avy auctex tern bind-map highlight haml-mode winum fuzzy flyspell-correct-helm flyspell-correct auto-dictionary ledger-mode flycheck-ledger csv-mode pdf-tools tablist fcitx async hydra iedit auto-complete rust-mode anaconda-mode yasnippet company smartparens evil undo-tree flycheck request helm helm-core markdown-mode alert projectile magit magit-popup git-commit with-editor f js2-mode s yapfify uuidgen py-isort pug-mode org-projectile org-download livid-mode skewer-mode simple-httpd live-py-mode link-hint git-link eyebrowse evil-visual-mark-mode evil-unimpaired evil-ediff dumb-jump company-shell company-emacs-eclim column-enforce-mode cargo yaml-mode ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe utop use-package tuareg toml-mode toc-org tagedit stickyfunc-enhance srefactor spacemacs-theme spaceline solarized-theme smooth-scrolling smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters racer quelpa pyvenv pytest pyenv-mode py-yapf popwin pip-requirements persp-mode pcre2el paradox page-break-lines orgit org-repo-todo org-present org-pomodoro org-plus-contrib org-bullets open-junk-file ocp-indent nlinum-relative neotree move-text mmm-mode merlin markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum linum-relative leuven-theme less-css-mode json-mode js2-refactor js-doc jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation highlight-escape-sequences help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gtags helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger gh-md ggtags flycheck-rust flycheck-pos-tip flx-ido fish-mode fill-column-indicator fasd fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav eclim disaster define-word cython-mode company-web company-tern company-statistics company-racer company-quickhelp company-c-headers company-anaconda coffee-mode cmake-mode clean-aindent-mode clang-format buffer-move bracketed-paste auto-yasnippet auto-highlight-symbol auto-compile android-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
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
 '(org-level-1 ((t (:inherit nil :foreground "#de322f" :height 1.0))))
 '(org-level-2 ((t (:inherit nil :foreground "#859900" :height 1.0))))
 '(org-level-3 ((t (:inherit nil :foreground "#268bd2" :height 1.0))))
 '(org-level-4 ((t (:inherit nil :foreground "#b58900" :height 1.0))))
 '(org-level-5 ((t (:inherit nil :foreground "#2aa198"))))
 '(org-level-6 ((t (:inherit nil :foreground "#859900"))))
 '(org-level-7 ((t (:inherit nil :foreground "#cb4b16"))))
 '(org-level-8 ((t (:inherit nil :foreground "#268bd2")))))
