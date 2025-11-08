{
  plugins.noice = {
    enable = true;
    settings = {
      cmdline = {
        view = "cmdline_popup";
      };

      # Show messages, errors, and prompts in a floating window.
      messages = {
        view = "mini";
        view_error = "mini";
        view_warn = "mini";
      };

      # Use a minimal popup for the command‑line.
      popupmenu = {
        backend = "cmp";
      };
    };
  };
  opts.cmdheight = 0;
}
