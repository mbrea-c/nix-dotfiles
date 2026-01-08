{ }:
{
  make-session-service =
    {
      target ? "sway-session.target",
      desc ? "",
      exec,
      ...
    }:
    {
      Unit = {
        Description = desc;
        BindsTo = [ target ];
        After = [ target ];
      };
      Install = {
        WantedBy = [ target ];
      };
      Service = {
        Type = "simple";
        ExecStart = exec;
      };
    };
}
