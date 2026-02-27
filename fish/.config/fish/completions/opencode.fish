function __opencode_yargs_completions
    set -l tokens (commandline -opc)
    if test (count $tokens) -eq 0
        set tokens opencode
    end
    opencode --get-yargs-completions $tokens
end

complete -c opencode -f -a '(__opencode_yargs_completions)'
