{
  programs.nushell.configFile.text = ''
    $env.config.hooks.pre_prompt = (
      $env.config.hooks.pre_prompt | append { ||
          if (which direnv | is-empty) {
              return
          }

          direnv export json | from json | default {} | load-env
          $env.PATH = $env.PATH | split row (char env_sep)
      }
    )
  '';
}
