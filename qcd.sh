qcd() {
    case "$1" in
        wiki)
            cd $HOME/git/shouts77.github.io
            ;;
        qt)
            cd $HOME/git/qtlog
            ;;
        study)
            cd $HOME/git/study
            ;;
        dotfiles)
            cd $HOME/git/dotfiles
            ;;
        *)
          echo "qcd: unknown key '$1'"
          return 1
          ;;
    esac

    pwd
}

# Set up tab completion
complete -W "wiki qt study" qcd
