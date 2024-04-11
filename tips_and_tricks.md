Before soloving any problem in CKAD exam, please try to do atleast the following to save some time during the exam

Add the following line to you ~/.bashrc or ~/.zshrc and source it using `source ~/.bashrc`.

```bash
alias k=kubectl
```

Add the following configuration to ~/.vimrc

```bash
set expandtab
set tabstop=2
set shiftwidth=2
```

Create few shorthands like
```bash
export dr="--dry-run=client -o yaml" # for creating yaml file quickly
```
