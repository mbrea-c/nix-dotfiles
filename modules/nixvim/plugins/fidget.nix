{ ... }: {
  plugins = {
    fidget = {
      enable = true;
      settings = {
        progress = { display = { done_ttl = 10; }; };
        notification = { override_vim_notify = true; };
      };
    };
  };
}
