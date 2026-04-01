{pkgs, ...}: {
  home.packages = with pkgs; [
    (python313.withPackages (python-pkgs:
      with python-pkgs; [
        ipython
        z3-solver
        matplotlib
        pyperclip
        websockets
        pygame-ce
        pydantic
      ]))
  ];
}
