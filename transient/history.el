((magit-blame
  ("-w"))
 (magit-branch nil)
 (magit-cherry-pick
  ("--ff")
  nil)
 (magit-commit nil)
 (magit-dispatch nil)
 (magit-fetch
  ("--prune")
  nil)
 (magit-log
  ("-n256" "--graph" "--color" "--decorate")
  ("-n256" "--graph" "--decorate"))
 (magit-log:-n "256")
 (magit-merge
  ("--no-ff"))
 (magit-pull nil)
 (magit-push nil
             ("--force-with-lease"))
 (magit-rebase
  ("--autostash")
  nil
  ("--preserve-merges")
  ("--preserve-merges" "--autostash"))
 (magit-revert
  ("--edit")
  nil)
 (magit-run nil)
 (magit-stash nil)
 (magit-status-jump nil)
 (magit-submodule nil))
