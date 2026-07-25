{
  delib,
  ...
}:
delib.module {
  name = "programs.bash";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        if [[ $- == *i* && $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z "$BASH_EXECUTION_STRING" ]]
        then
          shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""
          exec fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
