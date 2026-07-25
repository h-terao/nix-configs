{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    user = readOnly (
      attrsOfOption str {
        name = "hayato";
        fullname = "h-terao";
        email = "h-terao@ymail.ne.jp";
      }
    );
  };
}
